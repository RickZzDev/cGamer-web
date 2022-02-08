import 'package:cGamer/app/data/models/play_to_win_models/play_to_win_model.dart';
import 'package:cGamer/app/data/repository/play_to_win_repositories/play_to_win_repository.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/admob/admob_util.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../utils/admob/admob_util.dart';

class PlayToWinController extends GetxController {
  final PlayToWinRepository repository;

  int _currentPage = 0;

  List<PlayToWinGame>? games;
  PlayToWinController({required this.repository});
  PageController pageController = PageController();

  var currentGame = PlayToWinGameType.LEAGUE_OF_LEGENDS.obs;

  var hasLoadedGames = false.obs;
  var hasDetailsLoaded = false.obs;
  var loading = false.obs;
  var isAdRewarded = false.obs;
  AdmobUtil? admobUtil;

  GameInfo? gameInfoModel;
  bool isPrime = false;

  @override
  void onInit() async {
    isPrime = await PrimeUtils.isPrime();
    hasLoadedGames.value = await getPlayToWinGames();
    hasDetailsLoaded.value = await getLolAccountDetail();
    initAdmob();
    super.onInit();
  }

  bool get isLoading => false;

  int getCurrentGameId() {
    return games?[_currentPage].id ?? 0;
  }

  void initAdmob() {
    admobUtil = AdmobUtil();
    admobUtil?.initAdmob(AdLocale.PLAY_TO_WIN, null);
    admobUtil?.createRewardAd();
  }

  Future<bool> getPlayToWinGames() async {
    loading.value = true;
    try {
      var response = await repository.getPlayToWinGames();
      this.games = response;
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado, recarregue a página.", title: "Atenção");
      return false;
    }
  }

  void buttonOnTap(PlayToWinGameType type) async {
    switch (type) {
      case PlayToWinGameType.LEAGUE_OF_LEGENDS:
        if (!loading.value) {
          if (this.gameInfoModel?.connected ?? false) {
            if (this.gameInfoModel?.details?.rescueToday ?? false) {
              SnackBarUtils.showSnackBar(
                  desc:
                      'Resgate diário já realizado, retorne amanhã para ganhar mais Rubis.',
                  title: 'Atenção',
                  color: Colors.orange[400]);
            } else {
              // SYNC
              if (isPrime) {
                await this.syncAccount();
              } else {
                admobUtil?.showRewardAd(((event) async {
                  switch (event) {
                    case RewardAdEvent.rewarded:
                      isAdRewarded.value = true;
                      break;
                    case RewardAdEvent.closed:
                      if (isAdRewarded.value) {
                        await this.syncAccount();
                        isAdRewarded.value = false;
                      } else {
                        SnackBarUtils.showSnackBar(
                            desc:
                                'Assista o anúncio até o final, para sincronizar',
                            title: 'Atenção');
                      }
                      admobUtil?.loadRewardAd();
                      break;
                    default:
                      break;
                  }
                }));
              }
            }
          } else {
            Get.toNamed(Routes.LOL_CONNECTION,
                arguments: {'id': _getCurrentGameId(type)});
          }
        }
        break;
      case PlayToWinGameType.VALORANT:
        SnackBarUtils.showSnackBar(
            desc:
                'Já estamos trabalhando para liberar o função para o jogo Valorant.',
            title: "Em breve",
            color: Colors.orange[400]);
        break;
      default:
        break;
    }
  }

  bool buttonIsEnabled(PlayToWinGameType type) {
    switch (type) {
      case PlayToWinGameType.LEAGUE_OF_LEGENDS:
        if (this.gameInfoModel?.connected ?? false) {
          if (this.gameInfoModel!.details!.qtdGamesDaily! >= 5) {
            return true;
          }
          return false;
        }
        return true;
        break;
      case PlayToWinGameType.VALORANT:
        if (this.gameInfoModel?.connected ?? false) {
          if (this.gameInfoModel!.details!.qtdGamesDaily! >= 5) {
            return true;
          }
          return false;
        }
        return true;
        break;
      default:
        return true;
        break;
    }
  }

  String getButtonTitle(PlayToWinGameType type) {
    switch (type) {
      case PlayToWinGameType.LEAGUE_OF_LEGENDS:
        if (this.gameInfoModel?.connected ?? false) {
          return "Sincronizar jogos";
        }
        return "Conectar conta";
        break;
      case PlayToWinGameType.VALORANT:
        return "Em breve";
        break;
      default:
        return "";
        break;
    }
  }

  int? _getCurrentGameId(PlayToWinGameType type) {
    int? _gameId;

    this.games?.forEach((game) {
      if (game.getGameType() == type) {
        _gameId = game.id;
      }
    });

    if (_gameId != null) {
      return _gameId;
    }
    return null;
  }

  double pointsForRescue(PlayToWinGameType type) {
    switch (type) {
      case PlayToWinGameType.LEAGUE_OF_LEGENDS:
        return gameInfoModel!.details!.qtdGamesDaily! >= 5
            ? 5 * 10.0
            : gameInfoModel!.details!.qtdGamesDaily! * 10.0;
        break;
      case PlayToWinGameType.VALORANT:
        return 0.0;
        break;
      default:
        return 0.0;
        break;
    }
  }

  void gameOnTap(PlayToWinGameType type) {
    switch (type) {
      case PlayToWinGameType.LEAGUE_OF_LEGENDS:
        currentGame.value = type;
        this.pageController.jumpToPage(0);
        this._currentPage = 0;
        break;
      case PlayToWinGameType.VALORANT:
        currentGame.value = PlayToWinGameType.LEAGUE_OF_LEGENDS;
        // currentGame.value = type;
        // this.pageController.jumpToPage(1);
        // this._currentPage = 1;
        SnackBarUtils.showSnackBar(
            desc:
                'Já estamos trabalhando para liberar o função para o jogo Valorant.',
            title: "Em breve",
            color: Colors.orange[400]);
        return;
      default:
        print("Error with game type");
        break;
    }
  }

  Future<bool> getLolAccountDetail() async {
    loading.value = true;
    try {
      var response = await repository.getAccountDetail(getCurrentGameId());
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        this.gameInfoModel = response;
        return true;
      }
      return false;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível carregar, tente novamente.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> syncAccount() async {
    loading.value = true;
    try {
      var response = await repository.syncAccount(getCurrentGameId());
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        this.gameInfoModel = response;
        return true;
      }
      return false;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível sincronizar, tente novamente.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> rescuePoints() async {
    loading.value = true;
    try {
      var response = await repository.rescuePoints(getCurrentGameId());
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: 'Rubis resgatados com sucesso!',
            title: 'Parabéns',
            color: primaryColor);
        await this.getLolAccountDetail();
        return true;
      } else {
        SnackBarUtils.showSnackBar(
          desc: response.message,
          title: 'Atenção',
        );
      }
      return false;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(desc: e.toString(), title: "Atenção");
      return false;
    }
  }
}
