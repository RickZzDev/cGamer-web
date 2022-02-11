import 'dart:io';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

const int maxFailedLoadAttempts = 3;

class AdmobUtil {
  RewardedAd? _rewardAd;
  int _numRewardedLoadAttempts = 0;
  AdLocale? adLocale;
  ServerSideVerificationOptions? _options;
  String? userIdRecovery;
  String? customData;

  void initAdmob(AdLocale adLocale, String? customData) async {
    this.adLocale = adLocale;
    this.customData = customData;
    MobileAds.instance.initialize();

    String userId = await Provider.of<GetStorage>(Get.context, listen: false)
        .read('x-token');
    userIdRecovery = userId;
    _options =
        ServerSideVerificationOptions(userId: userId, customData: customData);
  }

  void createRewardAd() async {
    String userId = await Provider.of<GetStorage>(Get.context, listen: false)
        .read('x-token');
    _options = ServerSideVerificationOptions(
        userId: userId, customData: this.customData);

    RewardedAd.load(
        adUnitId: _getRewardBasedVideoAdUnitId(),
        request: AdRequest(),
        serverSideVerificationOptions: _options,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');

            this._rewardAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              createRewardAd();
            }
          },
        ));
  }

  void showRewardAd(Function(RewardAdEvent) handleEvent) async {
    if (_rewardAd != null) {
      _rewardAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            print('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          handleEvent(RewardAdEvent.closed);
          createRewardAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          handleEvent(RewardAdEvent.failed);
          createRewardAd();
        },
      );

      _rewardAd?.setImmersiveMode(true);

      _rewardAd?.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
        handleEvent(RewardAdEvent.rewarded);
      });
    } else {
      createRewardAd();
    }
  }

  void loadRewardAd() {
    //if (_rewardAd != null) {
    createRewardAd();
    //}
  }

  String _getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      //return 'ca-app-pub-3940256099942544/1712485313';
      switch (adLocale) {
        case AdLocale.WATCH_TO_WIN:
          return 'ca-app-pub-2194468870658186/2405009473';
        case AdLocale.ACCESS_TO_WIN:
          return 'ca-app-pub-2194468870658186/4435034147';
        case AdLocale.PLAY_TO_WIN:
          return 'ca-app-pub-2194468870658186/1090685501';
        case AdLocale.WATCH_WIN_CLA:
          return 'ca-app-pub-2194468870658186/5582428428';
        default:
          return '';
      }
    } else if (Platform.isAndroid) {
      //return 'ca-app-pub-3940256099942544/5224354917';
      switch (adLocale) {
        case AdLocale.WATCH_TO_WIN:
          return 'ca-app-pub-2194468870658186/8896419727';
        case AdLocale.ACCESS_TO_WIN:
          return 'ca-app-pub-2194468870658186/3254153728';
        case AdLocale.PLAY_TO_WIN:
          return 'ca-app-pub-2194468870658186/8350228429';
        case AdLocale.WATCH_WIN_CLA:
          return 'ca-app-pub-2194468870658186/9145257155';
        default:
          return '';
      }
    }
    return '';
  }

  void dispose() {
    _rewardAd?.dispose();
  }
}

enum AdLocale { WATCH_TO_WIN, ACCESS_TO_WIN, PLAY_TO_WIN, WATCH_WIN_CLA }
enum RewardAdEvent { open, closed, rewarded, failed, loaded }
