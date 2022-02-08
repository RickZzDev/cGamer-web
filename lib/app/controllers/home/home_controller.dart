import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/home_models/avatar_model.dart';
import 'package:cGamer/app/data/models/home_models/balance_model.dart';
import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/data/models/home_models/missions_model.dart';
import 'package:cGamer/app/data/models/home_models/news_model.dart';
import 'package:cGamer/app/data/models/home_models/podcast_model.dart';
import 'package:cGamer/app/data/models/user_account_models/register_model.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/avatar_bottom_sheet.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/cache_utils/embaixador_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import '../../utils/generic_utils/snackbar.dart';
import '../../utils/generic_utils/styles_utils.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({required this.repository});
  Rx<Future<StatusRegisterModel>?> statusRegister =
      Rx<Future<StatusRegisterModel>?>(null);

  final currentIndex = 0.obs;

  // Rx<Future<HomeModel>> homeModel = Rx<Future<HomeModel>>();
  Rx<Future?> hasCompletedHeaderRequest = Rx<Future?>(Future.value());
  Rx<Future?> hasCompletedStatusRequest = Rx<Future?>(Future.value());
  Rx<Future?> hasCompletedAvatarRequest = Rx<Future?>(Future.value());
  Rx<Future?> hasCompletedBalanceRequest = Rx<Future?>(Future.value());
  Rx<Future?> hasCompletedExtractRequest = Rx<Future?>(Future.value());
  Rx<Future?> hasCompletedNewsFeedRequest = Rx<Future?>(Future.value());
  var loading = false.obs;

  Function? changeTab;

  // Rx<Future<dynamic>> homeModel;
  ImagePicker picker = ImagePicker();
  Rx<HomeModel> homeResult = HomeModel().obs;
  Rx<MissionsModel> missionsResult = MissionsModel().obs;
  Rx<ExtractModel> extractResult = ExtractModel().obs;
  BalanceModel balanceModel = BalanceModel();
  NewsModel newsModel = NewsModel();
  PodcastModel podcastsModel = PodcastModel();
  Rx<StatusRegisterModel> statusRegisterResult = StatusRegisterModel().obs;

  bool isRegisterComplete = false;
  File? profileImage;
  AvatarModel? avatarModel;
  final hasProfileImage = false.obs;
  Color? colorsBackground;
  bool isPrime = false;
  bool isEmbaixador = false;

  bool verifyDocumentsSend() {
    if (statusRegisterResult.value.hasCompleteRegistration &&
        statusRegisterResult.value.hasSendDocumentation &&
        statusRegisterResult.value.statusBanlky == "APPROVED")
      return true;
    else
      return false;
  }

  Future<void> refreshPage() async {
    hasCompletedHeaderRequest.value = getHomeInfo();
    hasCompletedStatusRequest.value = getStatusRegister();
    hasCompletedAvatarRequest.value = getAvatars();
    // hasCompletedExtractRequest.value = getExtract();
    hasCompletedNewsFeedRequest.value = getNewsFeed();
    getPodcasts();
    return;
  }

  @override
  void onInit() async {
    isPrime = await PrimeUtils.isPrime();
    isEmbaixador = await EmbaixadorUtils.isEmbaixador();
    hasCompletedAvatarRequest.value = getAvatars();

    hasCompletedStatusRequest.value = getStatusRegister();
    hasCompletedHeaderRequest.value = getHomeInfo();
    //hasCompletedMissionsRequest.value = getMissions();
    // hasCompletedBalanceRequest.value = getBalance();
    // hasCompletedExtractRequest.value = getExtract();
    hasCompletedNewsFeedRequest.value = getNewsFeed();
    getPodcasts();
    super.onInit();
  }

  double barWidth() {
    if (statusRegisterResult.value.hasCompleteRegistration)
      return 0.6;
    else
      return 0.3;
  }

  String textPorcentage() {
    if (statusRegisterResult.value.hasCompleteRegistration)
      return "(60% completo)";
    else
      return "(30% completo)";
  }

  verifyColor(BuildContext _context) {
    if (statusRegisterResult.value.hasCompleteRegistration != null) {
      statusRegisterResult.value.hasCompleteRegistration &&
              statusRegisterResult.value.hasSendDocumentation
          ? colorsBackground = Theme.of(_context).accentColor
          : colorsBackground = Theme.of(_context).primaryColor;
    }
  }

  String getHeaderName() {
    return GenericUtils.getFirstSecondName(homeResult.value.customerNick ?? "");
  }

  Future getBalance() async {
    var response = await repository.getBalance();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return Future.error("Error");
    } else {
      balanceModel = BalanceModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    }
  }

  Future getStatusRegister() async {
    var response = await repository.getStatusRegister();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return Future.error("error");
    } else {
      statusRegisterResult.value = StatusRegisterModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      Provider.of<StatusRegisterModel>(Get.context, listen: false)
          .statusBanlky = statusRegisterResult.value.statusBanlky;
      Provider.of<StatusRegisterModel>(Get.context, listen: false)
              .hasCompleteRegistration =
          statusRegisterResult.value.hasCompleteRegistration;
      Provider.of<StatusRegisterModel>(Get.context, listen: false)
              .hasSendDocumentation =
          statusRegisterResult.value.hasSendDocumentation;
      verifyButtonStatus();
    }
  }

  void verifyButtonStatus() => statusRegisterResult.value.hasSendDocumentation
      ? isRegisterComplete = true
      : DoNothingAction();

  Future getMissions() async {
    try {
      var response = await repository.getMissions();
      missionsResult.value = MissionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      // return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Map<String, dynamic> getInitialDateAndFinalDate() {
    DateTime finalDate = DateTime.now();

    DateFormat formatter = DateFormat('yyyy-MM-dd');

    var initialDate = finalDate.subtract(Duration(days: 87));

    var formattedFinalDate = formatter.format(finalDate);

    var formattedInitialDate = formatter.format(initialDate);

    return {
      'initialDate': formattedInitialDate,
      'finalDate': formattedFinalDate
    };
  }

  Future getExtract() async {
    try {
      extractResult.value = await repository.getHomeExtract(
          size: 3,
          initialDate: getInitialDateAndFinalDate()['initialDate'],
          finalDate: getInitialDateAndFinalDate()['finalDate']);
    } catch (e) {
      return Future.error(e);
    }
  }

  showExtractDetailsModel(BuildContext context,
      {required TransactionExtract? transactionExtract, int? index}) {
    final details = transactionExtract?.details;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ExtractDetailsModal(
            transactionExtract: transactionExtract,
            details: details,
          );
        });
  }

  Future getHomeInfo() async {
    var response = await repository.getHomeStats();
    if (ExceptionUtils.verifyIfIsException(response)) {
    } else {
      homeResult.value = HomeModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      CacheUtils.addToCache(
          key: 'x-email', value: homeResult.value.customerEmail);
      PrimeUtils.set(isPrime: homeResult.value.isPrime);
      EmbaixadorUtils.set(isEmbaixador: homeResult.value.isEmbaixador);
      isPrime = homeResult.value.isPrime;
      isEmbaixador = homeResult.value.isEmbaixador;

      ///TODO uncomment
      // await _setupPushNotification();
    }
  }

  String getInitialsName() {
    String? nickName = homeResult.value.customerNick;
    return GenericUtils.getInitialsName(nickName);
  }

  double getPercentProgressBar() {
    if (homeResult.value.level != null &&
        homeResult.value.level?.nextLevelPoints != null) {
      double? nextPoints = homeResult.value.level?.nextLevelPoints ?? 0.0;
      double? customerPoints = homeResult.value.level?.customerPoints ?? 0.0;
      double? points = customerPoints > nextPoints
          ? nextPoints
          : homeResult.value.level?.customerPoints ?? 0.0;
      return ((100 * points) / nextPoints) / 100;
    } else {
      return 1.0;
    }
  }

  final _moneyVisibility = false.obs;

  changeVisibility(value) => this._moneyVisibility.value = value;

  get moneyVisibility => this._moneyVisibility.value;

  File? getProfileImageFile(String path) {
    if (profileImage == null) {
      if (path != "") {
        profileImage = File(path);
        hasProfileImage.value = true;
        hasProfileImage.refresh();
      }
    }
    return profileImage;
  }

  Future getAvatars() async {
    try {
      avatarModel = await repository.getAvatars();
    } catch (e) {
      return Future.error(e);
    }
  }

  // Future<bool> getRanking() async {
  //   var response = await repository.getRanking();
  //   if (ExceptionUtils.verifyIfIsException(response)) {
  //     return false;
  //   } else {
  //     rankingModelResult.value = RankingModel.fromJson(
  //       json.decode(utf8.decode(response.bodyBytes)),
  //     );
  //     return true;
  //   }
  // }

  void pickImage() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext bc) {
        return Builder(
          builder: (context) => AvatarModalBottomSheet(
            avatarSelected: homeResult.value.customerNick,
            isPrime: isPrime,
            avatarModel: avatarModel!,
            saveImage: sendAvatar,
          ),
        );
      },
    );
  }

  _changeLoading() => loading.value = !loading.value;

  _setCustomerAvatarOnHomeModel(dynamic avatarValue) {
    homeResult.value.customerAvatar = avatarValue;
    homeResult.refresh();
  }

  _changeValuesOnLocalAvatarObject(int _index) {
    avatarModel?.avatars?.forEach((element) {
      element.select = false;
    });
    if (_index != -1) avatarModel?.avatars?[_index].select = true;
  }

  _updateProfileAvatarImage() {
    DartNotificationCenter.post(channel: 'refreshProfile');
  }

  sendAvatar(int _index, String imgUrl) async {
    try {
      _changeLoading();
      await repository.sendAvatar(_index != -1 ? _index + 1 : _index);
      _updateProfileAvatarImage();
      _changeValuesOnLocalAvatarObject(_index);
      _setCustomerAvatarOnHomeModel(_index != -1 ? imgUrl : "");
      SnackBarUtils.showSnackBar(
          desc: "Seu avatar foi alterado.",
          title: "Sucesso",
          color: primaryColor);

      _changeLoading();
    } catch (e) {
      _changeLoading();
      SnackBarUtils.showSnackBar(
          desc: "Erro ao trocar seu avatar, tente novamente mais tarde",
          title: "Atenção");
    }
  }

  _setupPushNotification() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.clearOneSignalNotifications();
    OneSignal.shared.promptUserForPushNotificationPermission();
    // var settings = {
    //   OSiOSSettings.autoPrompt: false,
    //   OSiOSSettings.promptBeforeOpeningPushUrl: false
    // };

    OneSignal.shared.setAppId("459e89fb-4c9f-451e-893b-4ebe85940400");

    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    //_handleSetEmail();
    await _handleSetExternalUserId();
  }

  void _handleSetEmail() {
    if (homeResult.value.customerEmail != null) {
      OneSignal.shared.setEmail(email: homeResult.value.customerEmail ?? "");
    }
  }

  Future<void> _handleSetExternalUserId() async {
    String token = await Provider.of<GetStorage>(Get.context, listen: false)
        .read('x-token');
    OneSignal.shared.setExternalUserId(token);
  }

  bool listTransactionsIsEmpty(List<TransactionExtract>? list) {
    if (list == null || list.length == 0) {
      return true;
    }
    return false;
  }

  Future<ClanInfoModel> getClanInfo() async {
    loading.value = true;
    try {
      dynamic response = await repository.getClanInfo();

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        return Future.error("Não foi possivel localizar o clã.");
      } else {
        loading.value = false;
        return response;
      }
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      throw e;
    }
  }

  String getRemainingPointsLevel() {
    double nextLevelPoints = homeResult.value.level?.nextLevelPoints ?? 0.0;
    double customerPoints = homeResult.value.level?.customerPoints ?? 0.0;
    double remainingPoints = nextLevelPoints - customerPoints;
    String nextLevel = homeResult.value.level?.nextLevel ?? "";
    return nextLevel.replaceAll(
        " X ", " ${remainingPoints.formattedPoints()} ");
  }

  Future<void> getNewsFeed() async {
    Uri uri = Uri.https('noticias.maisesports.com.br', '/feed/');
    var client = http.Client();
    final myTranformer = Xml2Json();
    return await client.get(uri).then((response) {
      return response.body;
    }).then((bodyString) {
      myTranformer.parse(bodyString);
      var json = myTranformer.toGData();
      newsModel = NewsModel.fromJson(
        jsonDecode(json)['rss']['channel'],
      );
    });
  }

  Future<void> getPodcasts() async {
    loading.value = true;
    try {
      dynamic response = await repository.getPodcasts();

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
        return;
      } else {
        podcastsModel = response;
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      throw e;
    }

    // podcastsModel = PodcastModel();
    // List<PodcastFeed> podcasts = <PodcastFeed>[];
    // PodcastFeed podcast1 = PodcastFeed();
    // podcast1.title = "A importância dos Games nos dias atuais";
    // podcast1.image =
    //     "https://i.scdn.co/image/ab67656300005f1f13c29f4f9c7dfca906ce5d5e";
    // podcast1.duration = "1h 46min";
    // podcast1.creator = "PodcastGAMER";
    // podcast1.url =
    //     "https://open.spotify.com/episode/349hq0cse14KGFCgrgR80u?si=w1UAnA2KQuuWEtxlIzWVmw";
    // podcasts.add(podcast1);
    // PodcastFeed podcast2 = PodcastFeed();
    // podcast2.title = "#57 - Qual vai ser o Jogo do ano de 2021?";
    // podcast2.image =
    //     "https://i.scdn.co/image/ab67656300005f1fba3241d6e27299a0b4007732";
    // podcast2.duration = "1h 47min";
    // podcast2.creator = "Gamemania";
    // podcast2.url =
    //     "https://open.spotify.com/episode/0NYB9iYQcSZb4sAOQ4ZDZM?si=eyGheNoFTxu-D4m3NYp47A";
    // podcasts.add(podcast2);
    // podcastsModel.podcasts = podcasts;
  }
}
