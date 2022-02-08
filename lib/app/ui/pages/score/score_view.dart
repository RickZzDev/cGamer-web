import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/points_extract_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/provider/score_providers/score_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/score_repository/score_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/shimmers/score_shimmers/score_header_shimmer.dart';
import 'package:cGamer/app/ui/components/shimmers/score_shimmers/score_how_to_win_shimmer.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ScoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    Requester client = Requester();
    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);
    final HomeController _homeController = Get.put(
      HomeController(
        repository: HomeRepository(apiClient: _homeApiClient),
      ),
    );

    ScoreApiClient _scoreApiClient = ScoreApiClient(httpClient: client);
    ScoreController _scoreController = Get.put(ScoreController(
        repository: ScoreRepository(apiClient: _scoreApiClient)));

    PointsExtractController _extractController = Get.put(
        PointsExtractController(
            repository: ScoreRepository(apiClient: _scoreApiClient)));

    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _scoreController.loading.value,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _scoreController.onRefreshEarnView(),
              child: Container(
                height: screenHeigthSize,
                width: screenWidthhSize,
                child: Column(
                  children: [
                    Container(
                      height: screenHeigthSize * 0.02,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: secondaryColor,
                      ),
                      child: Column(
                        children: [
                          Obx(() =>
                              _scoreController.hasCompletedScoreResult.value
                                  ? ScoreHeader(
                                      controller: _scoreController,
                                    )
                                  : ScoreHeaderShimer()),
                          Expanded(
                            child: Obx(
                              () => DefaultTabController(
                                length: _scoreController.tabs.length,
                                child: Scaffold(
                                  appBar: PreferredSize(
                                    preferredSize: Size.fromHeight(50),
                                    child: AppBar(
                                      bottom: TabBar(
                                        indicatorColor: primaryColor,
                                        indicatorWeight: 4,
                                        tabs: _scoreController.tabs,
                                      ),
                                    ),
                                  ),
                                  body: Container(
                                    color: secondaryColor,
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Obx(() => _scoreController
                                                    .hasCompletedActionsResult
                                                    .value &&
                                                _scoreController
                                                    .hasCompletedMissons.value
                                            ? HowToWin(
                                                homeController: _homeController,
                                                scoreController:
                                                    _scoreController,
                                              )
                                            : ScoreHowToWinShimer()),
                                        Obx(() => _scoreController
                                                    .hasCompletedActionsResult
                                                    .value &&
                                                _scoreController
                                                    .hasCompletedeGiftCardsResult
                                                    .value
                                            ? TradePoints(
                                                scoreController:
                                                    _scoreController,
                                                homeController: _homeController,
                                              )
                                            : ScoreHowToWinShimer()),
                                        Obx(
                                          () => _extractController
                                                  .hasCompletedTransactionsResult
                                                  .value
                                              ? PointsExtract(
                                                  extractController:
                                                      _extractController)
                                              : Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
