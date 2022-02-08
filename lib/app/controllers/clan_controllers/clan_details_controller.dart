import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/data/models/clans_models/clan_play_win_trophy_model.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/profile_model/profile_model.dart';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_details_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/admob/admob_util.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/cache_utils/embaixador_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClanDetailsController extends GetxController {
  final ClanDetailsRepository repository;

  ClanDetailsController({required this.repository});

  int clanId = Get.arguments['clanId'];
  ClanDetailsModel? detailsModel;
  int membersQuantity = 0;
  var modelHasLoaded = false.obs;

  List<Tab>? tabs;
  List<Tab>? tabsNoMember;

  // Edit clan informations - Only to Admin
  TextEditingController? appBarTextController;
  TextEditingController? descriptionTextController;
  var isEditing = false.obs;
  CreateClanModel? editInformationsModel;
  User? _user;
  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;
  Rx<types.Room?> roomOfClan =
      types.Room(id: "", users: [], type: types.RoomType.group).obs;

  bool userHasClan = Get.arguments['userHasClan'] ?? false;
  //emblem
  RxList<EmblemGridItemModel> emblemsLinks = <EmblemGridItemModel>[].obs;
  var currentEmblem = ''.obs;

  var loading = false.obs;
  // earn trophy area
  Rx<PlayWinTrophyModel> playWinTrophyModel = PlayWinTrophyModel().obs;
  List<HowEarnModelItem> howEarnTrophyModels = [];
  RxList<PlayWinTrophyItem> playWinTrophyList = <PlayWinTrophyItem>[].obs;
  AdmobUtil? admobUtil;
  bool isPrime = false;
  bool isEmbaixador = false;

  @override
  void onInit() async {
    isPrime = await PrimeUtils.isPrime();
    isEmbaixador = await EmbaixadorUtils.isEmbaixador();
    DartNotificationCenter.registerChannel(channel: 'refreshCla');
    _subscribeListener();
    modelHasLoaded.value = await getClans().whenComplete(() {
      this.appBarTextController =
          TextEditingController(text: detailsModel?.name);
      this.descriptionTextController =
          TextEditingController(text: detailsModel?.description);

      getEmblems();
    });

    tabs = [
      Tab(
        child: Text(
          'Membros (${detailsModel?.qtdMembers})',
          style: textStyle.copyWith(fontSize: 16),
        ),
      ),
      Tab(
        child: Text(
          'Troféus',
          style: textStyle.copyWith(fontSize: 16),
        ),
      ),
      Tab(
        child: Text(
          'Chat',
          style: textStyle.copyWith(fontSize: 16),
        ),
      )
    ];

    tabsNoMember = [
      Tab(
        child: Text(
          'Membros (${detailsModel?.qtdMembers})',
          style: textStyle.copyWith(fontSize: 16),
        ),
      ),
      Tab(
        child: Text(
          'Troféus',
          style: textStyle.copyWith(fontSize: 16, color: Colors.white70),
        ),
      ),
      Tab(
        child: Text('Chat',
            style: textStyle.copyWith(fontSize: 16, color: Colors.white70)),
      )
    ];

    if (this.detailsModel?.isMember ?? false) {
      howEarnTrophyModels = buildModels();

      // playWinTrophyModels = buildPlayWinTropyArray();
      initAdmob();
      await getPlayWinTrophys();
      await getProfile();
      await initializeFlutterFire();
      await getRoomOfClan();
      initializeDateFormatting('pt_BR', null);
    }
    super.onInit();
  }

  Future<void> initializeFlutterFire() async {
    FirebaseChatCoreConfig config = FirebaseChatCoreConfig("rooms", "users");
    FirebaseChatCore.instance.setConfig(config);

    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        _user = user;
        String token = await Provider.of<GetStorage>(Get.context, listen: false)
            .read('x-token');
        if (_user == null) {
          try {
            final credential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: statusProfileResult.value.customerEmail ?? "",
              password: SecurityUtils.encodeTo64(
                  statusProfileResult.value.customerCPF ?? ""),
            );

            await FirebaseChatCore.instance.createUserInFirestore(
              types.User(
                  firstName: statusProfileResult.value.customerNick,
                  id: credential.user!.uid,
                  imageUrl: statusProfileResult.value.customerAvatar ??
                      "https://i.ibb.co/x5CpK1w/image-profile.png",
                  lastName: "",
                  metadata: {"token": token.replaceAll("/", "\/")}),
            );

            await repository.saveFirebaseId(credential.user!.uid);

            types.Room roomFirebase = await FirebaseChatCore.instance
                .room(detailsModel?.roomId ?? "")
                .first;

            List<types.User> users = roomFirebase.users;

            var contains = users.where((element) => element.id == user!.uid);
            if (contains.isEmpty) {
              users.add(types.User(
                firstName: statusProfileResult.value.customerNick,
                id: user!.uid,
                imageUrl: statusProfileResult.value.customerAvatar ??
                    "https://i.ibb.co/x5CpK1w/image-profile.png",
                lastName: "",
              ));

              await FirebaseFirestore.instance
                  .collection(config.roomsCollectionName)
                  .doc(detailsModel?.roomId ?? "")
                  .update({
                'userIds': users.map((u) => u.id).toList(),
                "userRoles": users.fold<Map<String, String?>>(
                  {},
                  (previousValue, user) => {
                    ...previousValue,
                    user.id: user.role?.toShortString(),
                  },
                ),
              });
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user?.uid ?? "x")
              .update({
            'metadata': {'token': token.replaceAll("/", "\/")}
          });

          await repository.saveFirebaseId(_user!.uid);

          types.Room? roomFirebase = await FirebaseChatCore.instance
              .room(detailsModel?.roomId ?? "")
              .first;

          List<types.User> users = roomFirebase.users;

          var contains = users.where((element) => element.id == user!.uid);
          if (contains.isEmpty) {
            users.add(types.User(
              firstName: statusProfileResult.value.customerNick,
              id: user!.uid,
              imageUrl: statusProfileResult.value.customerAvatar ??
                  "https://i.ibb.co/x5CpK1w/image-profile.png",
              lastName: "",
            ));

            await FirebaseFirestore.instance
                .collection(config.roomsCollectionName)
                .doc(detailsModel?.roomId ?? "")
                .update({
              'userIds': users.map((u) => u.id).toList(),
              "userRoles": users.fold<Map<String, String?>>(
                {},
                (previousValue, user) => {
                  ...previousValue,
                  user.id: user.role?.toShortString(),
                },
              ),
            });
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> getProfile() async {
    try {
      var response = await repository.getProfile();
      statusProfileResult.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );

      CacheUtils.addToCache(
          key: 'x-customerId',
          value: statusProfileResult.value.customerId.toString());

      statusProfileResult.refresh();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: statusProfileResult.value.customerEmail ?? "",
        password: SecurityUtils.encodeTo64(
            statusProfileResult.value.customerCPF ?? ""),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getRoomOfClan() async {
    roomOfClan.value =
        await FirebaseChatCore.instance.room(detailsModel?.roomId ?? "").first;
  }

  resetEditFields() {
    this.appBarTextController?.text = detailsModel?.name ?? "";
    this.descriptionTextController?.text = detailsModel?.description ?? "";
  }

  Future<bool> getClans() async {
    loading.value = true;
    try {
      var response = await repository.getClanDetails(this.clanId.toString());
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, recarregue a página.",
            title: 'Atenção');
        return false;
      }
      this.detailsModel = response;
      currentEmblem.value = detailsModel?.image ?? "";
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> updateCla(
      String name, String? description, String? iconImage) async {
    loading.value = true;

    CreateClanModel model = CreateClanModel();
    model.description = description;
    model.name = name;

    if (currentEmblem.value != '') {
      model.image = currentEmblem.value;
    }

    try {
      var response = await repository.updateCla(this.clanId.toString(), model);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: 'Atenção');
        return false;
      }
      modelHasLoaded.value = false;
      modelHasLoaded.value = await getClans();

      appBarTextController?.text = model.name ?? "";
      descriptionTextController?.text = model.description ?? "";
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> requestEntry() async {
    loading.value = true;
    try {
      var response = await repository.requestEntry(this.clanId.toString());
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, recarregue a página.",
            title: 'Atenção');
        return false;
      }
      modelHasLoaded.value = false;
      modelHasLoaded.value = await getClans();

      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> leftCla() async {
    loading.value = true;
    try {
      var response = await repository.leftCla(this.clanId.toString());
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, recarregue a página.",
            title: 'Atenção');
        return false;
      }
      modelHasLoaded.value = false;
      modelHasLoaded.value = await getClans();

      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  void initAdmob() {
    admobUtil = AdmobUtil();
    admobUtil?.initAdmob(AdLocale.WATCH_WIN_CLA, clanId.toString());
    admobUtil?.createRewardAd();
  }

  showAd() async {
    if (await _verifyAdmobLastView()) {
      admobUtil?.showRewardAd(((event) {
        switch (event) {
          case RewardAdEvent.rewarded:
            admobUtil?.loadRewardAd();
            SnackBarUtils.showSnackBar(
                desc: 'Você ganhou trófeus assistindo um vídeo.',
                title: 'Parabéns!',
                color: primaryColor);
            setAdmobLastView();
            break;
          default:
            break;
        }
      }));
    } else {
      SnackBarUtils.showSnackBar(
          color: Colors.orange[400],
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          desc:
              'Você pode assistir um novo vídeo a cada 5 minutos, aguarde e tente novamente.',
          title: "Atenção");
    }
  }

  Future<bool> _verifyAdmobLastView() async {
    String dateCache =
        await CacheUtils.readValue(key: 'cla_admob_last_view') ?? "";
    if (dateCache == "") {
      return true;
    }
    DateTime cacheDateTime =
        DateTime.parse(dateCache).add(Duration(seconds: 310));
    DateTime now = DateTime.now();

    if (cacheDateTime.isAfter(now)) {
      return false;
    }
    return true;
  }

  void setAdmobLastView() {
    DateTime now = DateTime.now();
    CacheUtils.addToCache(key: 'cla_admob_last_view', value: now.toString());
  }

  //Trophy area
  List<PlayWinTrophyItem> buildPlayWinTropyArray() {
    List<PlayWinTrophyItem> modelsArray = [];
    PlayWinTrophyItem itemAutomatic = PlayWinTrophyItem();
    itemAutomatic.action = "AUTOMATIC";
    itemAutomatic.description = "Troféu grátis para resgatar sempre";
    itemAutomatic.title = "Resgate um troféu";
    itemAutomatic.lastActionDate = "2021-10-09 22:06:00";
    itemAutomatic.iconUrl = "assets/images/marketplace/Streaming.svg";
    itemAutomatic.buttonTitle = "Resgatar";
    itemAutomatic.containsCounter = true;

    PlayWinTrophyItem itemRoulette = PlayWinTrophyItem();
    itemRoulette.action = "ROULETTE";
    itemRoulette.description = "A roleta da sorte é generosa";
    itemRoulette.title = "Rode a roleta";
    itemRoulette.lastActionDate = "2021-10-09 22:03:22";

    //"2021-10-09 21:45:00"
    itemRoulette.iconUrl = "assets/images/home_images/Recarga_de_celular.svg";
    itemRoulette.buttonTitle = "Rodar";
    itemRoulette.containsCounter = true;

    PlayWinTrophyItem itemCaca = PlayWinTrophyItem();
    itemCaca.action = "CACA_TROPHY";
    itemCaca.description = "Junte-se ao clã para encontrar troféus";
    itemCaca.title = "Caça aos troféus";
    itemCaca.lastActionDate = null;
    itemCaca.iconUrl = "assets/images/profile_images/Indique_Amigo.svg";
    itemCaca.buttonTitle = "Caçar";
    itemCaca.containsCounter = false;

    PlayWinTrophyItem itemMachine = PlayWinTrophyItem();
    itemMachine.action = "MACHINE";
    itemMachine.description = "Produza troféus durante um períoodo";
    itemMachine.title = "Máquina de trófeus";
    itemMachine.lastActionDate = null;
    itemMachine.iconUrl = "assets/images/profile_images/Indique_Amigo.svg";
    itemMachine.buttonTitle = "Conferir";
    itemMachine.containsCounter = false;

    modelsArray.add(itemAutomatic);
    modelsArray.add(itemRoulette);
    modelsArray.add(itemCaca);
    modelsArray.add(itemMachine);

    return modelsArray;
  }

  List<HowEarnModelItem> buildModels() {
    List<HowEarnModelItem> modelsArray = [];
    HowEarnModelItem modelAd = HowEarnModelItem();
    modelAd.action = "SHOW_AD";
    modelAd.description = "Ganhe troféus assistindo anúncios até o final";
    modelAd.title = "Assista um vídeo";
    modelAd.earnPoints = "2 troféus por vídeo";
    modelAd.iconUrl = "assets/images/marketplace/Streaming.svg";

    HowEarnModelItem modelPayBill = HowEarnModelItem();
    modelPayBill.action = "PAY_BILL";
    modelPayBill.description = "Troféus também quando pagar suas contas";
    modelPayBill.title = "Pague seus boletos";
    modelPayBill.earnPoints = "10 troféus por boleto pago";
    modelPayBill.iconUrl = "assets/images/home_images/Pagar_contas.svg";

    HowEarnModelItem modelRechargeCell = HowEarnModelItem();
    modelRechargeCell.action = "RECHARGE_PHONE";
    modelRechargeCell.description = "Coloque créditos para ganhar troféus";
    modelRechargeCell.title = "Recarregue seu celular";
    modelRechargeCell.earnPoints = "40 troféus por recarga";
    modelRechargeCell.iconUrl =
        "assets/images/home_images/Recarga_de_celular.svg";

    HowEarnModelItem modelInviteFriend = HowEarnModelItem();
    modelInviteFriend.action = "INVITE_FRIEND";
    modelInviteFriend.description = "Seu amigo precisa ativar a conta";
    modelInviteFriend.title = "Convidando amigos";
    modelInviteFriend.earnPoints = "50 troféus por indicação";
    modelInviteFriend.iconUrl =
        "assets/images/profile_images/Indique_Amigo.svg";

    modelsArray.add(modelAd);
    modelsArray.add(modelInviteFriend);
    modelsArray.add(modelRechargeCell);
    modelsArray.add(modelPayBill);

    return modelsArray;
  }

  int? getTimeLeft(String? date) {
    if (date == null) {
      DateTime dateLastAction = DateTime.now();
      DateTime dateNextAction = dateLastAction.add(Duration(minutes: 10));
      return dateNextAction.millisecondsSinceEpoch;
    } else {
      DateTime dateLastAction =
          new DateFormat("dd/MM/yyyy hh:mm:ss").parse(date);
      DateTime dateNextAction = dateLastAction.add(Duration(minutes: 10));
      dateNextAction = dateNextAction.add(Duration(hours: 3));
      DateTime now = DateTime.now();
      dateNextAction = dateNextAction.add(now.timeZoneOffset);
      return dateNextAction.millisecondsSinceEpoch;
    }
  }

  void emblemTap(int id) {
    emblemsLinks.forEach((element) {
      if (element.id == id) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });

    this.emblemsLinks.refresh();
  }

  void saveEmblem() {
    bool hasEmblemSelected = false;

    emblemsLinks.forEach((element) {
      if (element.isSelected) {
        this.currentEmblem.value = element.urlImage;
        hasEmblemSelected = true;

        Get.back();
      }
    });

    detailsModel?.image = currentEmblem.value;
    modelHasLoaded.refresh();

    !hasEmblemSelected
        ? SnackBarUtils.showSnackBar(
            desc: "Você não selecionou nenhum emblema.", title: "Atenção")
        : DoNothingAction();
  }

  void openEmblemModal() {
    showModalBottomSheet(
        backgroundColor: secondaryColor,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          return Builder(
              builder: (context) => EmblemModal(
                    emblemTap: emblemTap,
                    emblemsList: emblemsLinks,
                    onSaveTap: saveEmblem,
                  ));
        });
  }

  Future<bool> getEmblems() async {
    try {
      var response = await repository.getEmblems();

      if (ExceptionUtils.verifyIfIsException(response)) {
        dynamic error = response;

        SnackBarUtils.showSnackBar(desc: error.message, title: "Atenção");
        return false;
      }
      this.emblemsLinks.value = response.emblems;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> getPlayWinTrophys() async {
    loading.value = true;
    try {
      var response = await repository.getPlayWinTrophys();
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        dynamic error = response;

        SnackBarUtils.showSnackBar(desc: error.message, title: "Atenção");
        return false;
      }
      playWinTrophyModel.value = response;
      playWinTrophyList.value = response.howEarns ?? [];

      playWinTrophyModel.refresh();
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> rescueTrophy() async {
    loading.value = true;
    try {
      var response = await repository.rescueTrophy();
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        dynamic error = response;

        SnackBarUtils.showSnackBar(desc: error.message, title: "Atenção");
        return false;
      }

      SnackBarUtils.showSnackBar(
          desc: 'Troféu resgatado com sucesso!',
          title: 'Parabéns :)',
          color: primaryColor);

      DartNotificationCenter.post(channel: 'refreshCla');

      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  void refreshPage() async {
    modelHasLoaded.value = await getClans();
    await getPlayWinTrophys();
  }

  _subscribeListener() {
    DartNotificationCenter.subscribe(
      channel: 'refreshCla',
      observer: this,
      onNotification: (options) {
        refreshPage();
      },
    );
  }
}
