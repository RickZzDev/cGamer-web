import 'dart:convert';
import 'dart:io';

import 'package:cGamer/app/data/models/home_models/missions_model.dart';
import 'package:cGamer/app/data/models/play_to_win_models/play_to_win_model.dart';
import 'package:cGamer/app/data/models/score_models/challenge_model.dart';
import 'package:cGamer/app/data/models/score_models/daily_model.dart';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/data/models/score_models/score_model.dart';
import 'package:cGamer/app/data/repository/score_repository/score_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/admob/admob_util.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ayetstudios/flutter_ayetstudios.dart';
import 'package:flutter_ayetstudios/ios.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/admob/admob_util.dart';

const String testDevice = 'ae2ea6af544281ac8f1f1106a00fcfc3';

class ScoreController extends GetxController {
  final ScoreRepository repository;

  ScoreController({required this.repository});

  Rx<ScoreModel> scoreModelResult = ScoreModel().obs;
  Rx<ChallengesModel> challengesModelResult = ChallengesModel().obs;
  Rx<RankingModel> rankingModelResult = RankingModel().obs;
  Rx<DaysModel> daysModelResult = DaysModel().obs;
  Rx<HowEarnModel> howEarnModel = HowEarnModel().obs;
  Rx<GiftCardModel> giftCardResult = GiftCardModel().obs;
  Rx<MissionsModel> missionsResult = MissionsModel().obs;
  List<PlayToWinGame>? games;

  int indexCurrentDay = -1;
  final hasCompletedScoreResult = false.obs;
  final hasCompletedRankingResult = false.obs;
  final hasCompletedDailyResult = false.obs;
  final hasCompletedHowEarnResult = false.obs;
  final hasCompletedeGiftCardsResult = false.obs;
  final hasCompletedActionsResult = false.obs;
  final hasCompletedPlayToWinGames = false.obs;
  final hasCompletedMissons = false.obs;
  final loading = false.obs;
  final adIsRewarded = false.obs;

  AdmobUtil? admobUtil;
  AdmobUtil? admobDailyAccess;
  bool isPrime = false;

  @override
  void onInit() async {
    isPrime = await PrimeUtils.isPrime();
    DartNotificationCenter.registerChannel(channel: 'refreshScore');
    _subscribeListener();

    _initAdmob();
    super.onInit();
  }

  showAd() async {
    if (await _verifyAdmobLastView()) {
      admobUtil?.showRewardAd(((event) {
        switch (event) {
          case RewardAdEvent.rewarded:
            admobUtil?.loadRewardAd();
            SnackBarUtils.showSnackBar(
                desc: 'Você ganhou Rubis assistindo um vídeo.',
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

  _initAdmob() {
    admobUtil = AdmobUtil();
    admobUtil?.initAdmob(AdLocale.WATCH_TO_WIN, null);
    admobUtil?.createRewardAd();

    admobDailyAccess = AdmobUtil();
    admobDailyAccess?.initAdmob(AdLocale.ACCESS_TO_WIN, null);
    admobDailyAccess?.createRewardAd();
  }

  _subscribeListener() {
    DartNotificationCenter.subscribe(
      channel: 'refreshScore',
      observer: this,
      onNotification: (options) async {
        hasCompletedScoreResult.value = await getScore();
      },
    );
  }

  @override
  void onReady() async {
    hasCompletedScoreResult.value = await getScore();
    hasCompletedDailyResult.value = await getDaily();
//    hasCompletedRankingResult.value = await getRanking();
    hasCompletedHowEarnResult.value = await getHowEarn();
    hasCompletedActionsResult.value = await getActions();
    hasCompletedeGiftCardsResult.value = await getGiftCards();
    hasCompletedMissons.value = await getMissions();
    // _createRewardedAd();
    super.onReady();
  }

  Future<void> onRefreshEarnView() async {
    hasCompletedActionsResult.value = await getActions();
    hasCompletedDailyResult.value = await getDaily();
    hasCompletedScoreResult.value = await getScore();
    hasCompletedMissons.value = await getMissions();
  }

//356.5
  Future<void> onRefreshRankingView() async {
    //  hasCompletedRankingResult.value = await getRanking();
    hasCompletedScoreResult.value = await getScore();
  }

  Future<bool> getScore() async {
    var response = await repository.getScore();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      scoreModelResult.value = ScoreModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      scoreModelResult.refresh();
      return true;
    }
  }

  Future<bool> getHowEarn() async {
    try {
      var response = await repository.getHowEarnList();

      howEarnModel.value = response;

      return true;
    } catch (e) {
      print(e);
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> getActions() async {
    var response = await repository.getActions();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      challengesModelResult.value = ChallengesModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  Future<bool> getDaily() async {
    var response = await repository.getDaily();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      indexCurrentDay = -1;
      daysModelResult.value = DaysModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      daysModelResult.refresh();
      return true;
    }
  }

  void checkInDaily(int id) async {
    loading.value = true;
    var response = await repository.checkInDaily(id);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: response.message.toString(), title: "Atenção");
    } else {
      loading.value = false;
      if (isPrime) {
        SnackBarUtils.showSnackBar(
            desc: "Você ganhou Rubis por fazer seu check-in diário!",
            title: "Parabéns",
            color: primaryColor);
      } else {
        admobDailyAccess?.showRewardAd(((event) async {
          switch (event) {
            case RewardAdEvent.rewarded:
              adIsRewarded.value = true;
              break;
            case RewardAdEvent.closed:
              admobDailyAccess?.loadRewardAd();
              if (adIsRewarded.value) {
                SnackBarUtils.showSnackBar(
                    desc: "Você ganhou Rubis por fazer seu check-in diário!",
                    title: "Parabéns",
                    color: primaryColor);
              }
              adIsRewarded.value = false;
              break;
            case RewardAdEvent.failed:
              admobDailyAccess?.loadRewardAd();
              adIsRewarded.value = false;
              break;
            default:
              break;
          }
        }));
      }

      indexCurrentDay = -1;

      await getDaily();
      await getScore();
      DartNotificationCenter.post(channel: "refreshHome");
      DartNotificationCenter.post(channel: "refreshProfile");
    }
  }

  Future<bool> getRanking() async {
    var response = await repository.getRanking();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      rankingModelResult.value = RankingModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  String getRemainingPointsLevel() {
    double nextLevelPoints =
        scoreModelResult.value.customerLevel?.nextLevelPoints ?? 0.0;
    double customerPoints =
        scoreModelResult.value.customerLevel?.customerPoints ?? 0.0;
    double remainingPoints = nextLevelPoints - customerPoints;
    String nextLevel = scoreModelResult.value.customerLevel?.nextLevel ?? "";
    return nextLevel.replaceAll(
        " X ", " ${remainingPoints.formattedPoints()} ");
  }

  final List<Tab> tabs = [
    Tab(
        child: Text(
      "Ganhe",
      style: textStyle.copyWith(fontSize: 16),
    )),
    Tab(
        child: Text(
      "Troque",
      style: textStyle.copyWith(fontSize: 16),
    )),
    Tab(
        child: Text(
      "Extrato",
      style: textStyle.copyWith(fontSize: 16),
    ))
  ].obs;

  double getPercentProgressBar() {
    if (scoreModelResult.value.customerLevel != null) {
      double nextPoints =
          scoreModelResult.value.customerLevel?.nextLevelPoints ?? 0.0;
      double customerPoints =
          scoreModelResult.value.customerLevel?.customerPoints ?? 0.0;
      double points = customerPoints > nextPoints ? nextPoints : customerPoints;
      return ((100 * points) / nextPoints) / 100;
    } else {
      return 1.0;
    }
  }

  void showAlertInfo(String? message) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: textStyle.copyWith(
            color: secondaryColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content:
          Text(message ?? "", style: textStyle.copyWith(color: secondaryColor)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void setupAyeTStudios() async {
    if (Platform.isAndroid) {
      await AyeTStudios.instance.init(uid: '2');
    } else if (Platform.isIOS) {
      AyeTStudiosIOS.instance.sdkLogEnable();
      AyeTStudiosIOS.instance
          .init(appKey: '9e09011f970d62f4c9d4651ca3f244ef', uid: '2');
    }
  }

  Future<void> showOfferWall() async {
    if (Platform.isIOS) {
      const url =
          'https://www.ayetstudios.com/offers/web_offerwall/4709?external_identifier=2';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Could not launch $url";
      }
    } else {
      await AyeTStudios.instance.show('jogga_drop_android');
    }
  }

  Future<void> showPartners() async {
    Get.toNamed(Routes.PARTNERS_POINTS_LIST);
  }

  Future<bool> _verifyAdmobLastView() async {
    String dateCache = await CacheUtils.readValue(key: 'admob_last_view') ?? "";
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
    CacheUtils.addToCache(key: 'admob_last_view', value: now.toString());
  }

  @override
  void dispose() {
    super.dispose();
    // _rewardedAd?.dispose();
  }

  Future<bool> getGiftCards() async {
    try {
      giftCardResult.value = await repository.getGiftCards();
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, aguarde alguns instantes.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> getMissions() async {
    try {
      var response = await repository.getMissions();
      missionsResult.value = MissionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
