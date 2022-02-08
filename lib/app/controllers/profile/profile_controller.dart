import 'dart:convert';
import 'dart:io';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/home_models/avatar_model.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/models/profile_model/games_model/games_model.dart';
import 'package:cGamer/app/data/models/score_models/buy_badges/my_badges_model.dart';
import 'package:cGamer/app/data/models/user_account_models/register_model.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/profile_repositories/profile_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/avatar_bottom_sheet.dart';
import 'package:cGamer/app/ui/components/home_components/user_register_status.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/cache_utils/embaixador_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
//import 'package:zendesk/zendesk.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  ProfileController({required this.repository});

  HomeRepository homeRepository =
      HomeRepository(apiClient: HomeApiClient(httpClient: Requester()));

  var hasCompletedProfileRequest = false.obs;
  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;
  Rx<StatusRegisterModel> statusRegisterResult = StatusRegisterModel().obs;
  File? profileImage;
  final hasProfileImage = false.obs;
  Rx<Future?> hasCompletedStatusRequest = Rx<Future?>(null);

  var hasCompletedBedgesRequest = false.obs;
  var hasCompletedSelectedGames = false.obs;

  ImagePicker picker = ImagePicker();
  // Zendesk zendesk = Zendesk();

  var loading = false.obs;
  var isPrime = false.obs;
  var isEmbaixador = false.obs;
  AvatarModel? avatarModel;
  ProfileGamesModel gamesList = ProfileGamesModel();
  Rx<ProfileGamesModel> selectedGamesList = ProfileGamesModel().obs;

  MyBadgesModel badgesModel = MyBadgesModel();

  @override
  void onReady() async {
    getAvatars();
    getGames();
    isPrime.value = await PrimeUtils.isPrime();
    isEmbaixador.value = await EmbaixadorUtils.isEmbaixador();
    hasCompletedBedgesRequest.value = await getBadges();
    hasCompletedSelectedGames.value = await getSelectedGames();
    hasCompletedStatusRequest.value = await getStatusRegister();
    hasCompletedProfileRequest.value = await getProfile();
    super.onReady();
  }

  refreshSelectedGames() async {
    hasCompletedSelectedGames.value = false;
    hasCompletedSelectedGames.value = await getSelectedGames();
  }

  Future getAvatars() async {
    try {
      avatarModel = await homeRepository.getAvatars();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getSelectedGames() async {
    try {
      selectedGamesList.value = await homeRepository.getSelectedGames();
      print(selectedGamesList);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  bool selectedGamesAreEmpty() {
    if (selectedGamesList.value.games?.length == 0) {
      return true;
    }
    return false;
  }

  Future<dynamic> getGames() async {
    try {
      var _gamesList = await homeRepository.getGames();

      if (ExceptionUtils.verifyIfIsException(_gamesList)) {
        print(_gamesList);
      }

      gamesList = _gamesList;
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  dynamic getBadges() async {
    try {
      var _badgeModel = await repository.getBadges();

      if (ExceptionUtils.verifyIfIsException(_badgeModel)) {
        print(_badgeModel);
      }

      badgesModel = _badgeModel;
      print(badgesModel);
      return true;
    } catch (e) {
      print(e);
    }
  }

  bool badgesAreEmpty() {
    if (badgesModel.badges == null) {
      return true;
    }
    return false;
  }

  bool badgesAndSelectedGamesHasLoaded() {
    if (hasCompletedBedgesRequest.value && hasCompletedSelectedGames.value) {
      return true;
    }
    return false;
  }

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
            avatarSelected: statusProfileResult.value.customerNick,
            avatarModel: avatarModel!,
            isPrime: isPrime.value,
            saveImage: sendAvatar,
          ),
        );
      },
    );
  }

  _changeLoading() => loading.value = !loading.value;

  _setCustomerAvatarOnHomeModel(dynamic avatarValue) {
    statusProfileResult.value.customerAvatar = avatarValue;
    statusProfileResult.refresh();
  }

  _changeValuesOnLocalAvatarObject(int _index) {
    avatarModel?.avatars?.forEach((element) {
      element.select = false;
    });
    if (_index != -1) avatarModel?.avatars?[_index].select = true;
  }

  _updateHomeAvatarImage() {
    DartNotificationCenter.post(channel: 'refreshHome');
  }

  sendAvatar(int _index, String imgUrl) async {
    try {
      _changeLoading();
      await homeRepository.sendAvatar(_index != -1 ? _index + 1 : _index);
      _updateHomeAvatarImage();
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
          title: "Atenção",
          color: Colors.red);
    }
  }

  @override
  void onInit() async {
    DartNotificationCenter.registerChannel(channel: 'refreshProfile');
    _subscribeListener();
    super.onInit();
  }

  _subscribeListener() {
    DartNotificationCenter.subscribe(
      channel: 'refreshProfile',
      observer: this,
      onNotification: (options) {
        refreshPage();
      },
    );
  }

  Future<void> refreshPage() async {
    hasCompletedStatusRequest.value = await getStatusRegister();
    hasCompletedProfileRequest.value = false;
    hasCompletedProfileRequest.value = await getProfile();
    hasCompletedBedgesRequest.value = false;
    hasCompletedBedgesRequest.value = await getBadges();
    hasCompletedSelectedGames.value = false;
    hasCompletedSelectedGames.value = await getSelectedGames();
    getAvatars();
    await Future.delayed(Duration(seconds: 1));
    return;
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
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> getStatusRegister() async {
    try {
      var response = await homeRepository.getStatusRegister();
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
      statusRegisterResult.refresh();
    } catch (e) {
      return Future.error(e);
    }
  }

  bool verifyDocumentsSend() {
    if (statusRegisterResult.value.hasCompleteRegistration &&
        statusRegisterResult.value.hasSendDocumentation &&
        statusRegisterResult.value.statusBanlky == "APPROVED")
      return true;
    else
      return false;
  }

  double getPercentProgressBar() {
    if (statusProfileResult.value.level != null &&
        statusProfileResult.value.level?.nextLevelPoints != null) {
      double nextPoints = statusProfileResult.value.level?.nextLevelPoints ?? 0;
      double customerPoints =
          statusProfileResult.value.level?.customerPoints ?? 0;
      double points = customerPoints > nextPoints ? nextPoints : customerPoints;
      return ((100 * points) / nextPoints) / 100;
    } else {
      return 1.0;
    }
  }

  String getInitialsName() {
    String nickName = statusProfileResult.value.customerNick ?? "";
    return GenericUtils.getInitialsName(nickName);
  }

  void goToMyProgress(_) {
    Get.toNamed(Routes.MY_BADGES);
  }

  void goToChangePassword() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  void goToSecurity() {
    Get.toNamed(Routes.SECURITY);
  }

  void goAccountDataList() {
    Get.toNamed(Routes.ACCOUNT_DATA_LIST);
  }

  void goToFAQ() {
    // Freshchat.resetUser();
    // Freshchat.showFAQ(
    //     faqTitle: "Perguntas frequentes",
    //     showContactUsOnFaqScreens: true,
    //     showContactUsOnAppBar: true,
    //     showFaqCategoriesAsGrid: true,
    //     showContactUsOnFaqNotHelpful: true);
    Get.toNamed(Routes.FAQ_CATEGORY);
  }

  void goToChat() async {
    FreshchatUser freshchatUser = FreshchatUser(null, null);
    freshchatUser.setFirstName(statusProfileResult.value.customerName ?? "");
    freshchatUser.setLastName(" ");
    freshchatUser.setEmail(statusProfileResult.value.customerEmail ?? "");
    freshchatUser.setPhone(
        "+55", statusProfileResult.value.customerPhone ?? "");
    Freshchat.setUser(freshchatUser);
    Freshchat.showConversations();
    // await zendesk.clearVisitorNotes();

    // await zendesk.setVisitorInfo(
    //     name: statusProfileResult.value.customerName,
    //     email: statusProfileResult.value.customerEmail,
    //     phoneNumber: statusProfileResult.value.customerPhone ?? "");

    // await zendesk.startChat(
    //   iosBackButtonTitle: "Sair",
    //   isAgentAvailabilityEnabled: false,
    //   isOfflineFormEnabled: true,
    //   isPreChatFormEnabled: true,
    //   isChatTranscriptPromptEnabled: true,
    //   iosNavigationTitleColor: Colors.white,
    //   iosNavigationBarColor: secondaryColor,
    // );
  }

  void goToInviteFriend() {
    Get.toNamed(Routes.INVITE_FRIEND, arguments: {
      'indication_code': statusProfileResult.value.indicationCode
    });
  }

  File? getProfileImageFile(String path) {
    if (profileImage == null) {
      if (path != null && path != "") {
        profileImage = File(path);
        hasProfileImage.value = true;
        hasProfileImage.refresh();
      }
    }
    return profileImage;
  }

  void goToLogout(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Não",
        style: textStyle.copyWith(
            color: secondaryColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Sim",
        style: textStyle.copyWith(color: secondaryColor),
      ),
      onPressed: () {
        GenericUtils.logoutUser();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text("Você realmente deseja sair?",
          style: textStyle.copyWith(color: secondaryColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
