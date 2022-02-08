import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid.dart';
import 'package:cGamer/app/ui/components/home_components/home_title_divider_component.dart';
import 'package:cGamer/app/ui/components/home_components/more_actions.dart';
import 'package:cGamer/app/ui/components/home_components/news_carousel.dart';
import 'package:cGamer/app/ui/components/home_components/podcast_carousel.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner.dart';
import 'package:cGamer/app/ui/components/home_components/ranking_top3/ranking_top3.dart';
import 'package:cGamer/app/ui/components/home_components/socials_carousel.dart';
import 'package:cGamer/app/ui/components/home_components/user_register_status.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomePage extends StatefulWidget {
  HomePage(this.changeTab);
  final Function changeTab;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    Requester client = Requester();

    HomeApiClient _apiClient = HomeApiClient(httpClient: client);
    final HomeController _controller = Get.put(
      HomeController(
        repository: HomeRepository(apiClient: _apiClient),
      ),
    );
    _controller.changeTab = widget.changeTab;
    _controller.colorsBackground = Theme.of(context).primaryColor;

    var singleChildScrollView = Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Obx(() {
              _controller.verifyColor(context);
              return Container(
                color: _controller.colorsBackground,
                padding: EdgeInsets.only(bottom: 0),
                child: FutureBuilder(
                  future: Future.wait([
                    _controller.hasCompletedStatusRequest.value!,
                    _controller.hasCompletedNewsFeedRequest.value!,
                    _controller.hasCompletedHeaderRequest.value!,
                    _controller.hasCompletedAvatarRequest.value!
                  ]),
                  builder: (context, AsyncSnapshot _snapshots) {
                    if (_snapshots.connectionState == ConnectionState.done)
                      return Obx(
                        () => HomeHeader(
                          controller: _controller,
                          userStats: _controller.homeResult.value,
                        ),
                      );
                    else
                      return HomeHeaderShimer();
                  },
                ),
              );
            }),
            // Obx(() => FutureBuilder(
            //     future: Future.wait([
            //       _controller.hasCompletedStatusRequest.value!,
            //       _controller.hasCompletedHeaderRequest.value!,
            //       _controller.hasCompletedBalanceRequest.value!,
            //     ]),
            //     builder: (context, snapshots) {
            //       if (snapshots.connectionState == ConnectionState.done) {
            //         if (_controller.statusRegisterResult.value.statusBanlky ==
            //             'APPROVED') {
            //           return SizedBox(
            //             height: 0,
            //             width: 0,
            //           );
            //         }
            //         return Padding(
            //             padding: EdgeInsets.only(top: 8),
            //             child: UserRegisterStatus(
            //               controller: _controller,
            //             ));
            //       }
            //       return SizedBox(
            //         height: 0,
            //         width: 0,
            //       );
            //     })),
            Container(
              child: Obx(
                () => FutureBuilder(
                  future: Future.wait([
                    _controller.hasCompletedStatusRequest.value!,
                    _controller.hasCompletedNewsFeedRequest.value!,
                    _controller.hasCompletedHeaderRequest.value!,
                    _controller.hasCompletedAvatarRequest.value!
                  ]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshots) {
                    if (snapshots.connectionState == ConnectionState.done)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !_controller.isPrime ? ProBanner() : Container(),
                            HomeGrid(
                              controller: _controller,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            MoreActionsHome(),
                            SizedBox(
                              height: 16,
                            ),
                            TitleDivider(
                                title: 'Notícias recentes',
                                actionTitle: null,
                                onTap: null),
                            // HomeCarousel(
                            //   controller: _controller,
                            // ),
                            NewsCarousel(controller: _controller),
                            TitleDivider(
                                title: 'Podcasts sugeridos',
                                actionTitle: null,
                                onTap: null),
                            PodcastCarousel(controller: _controller),

                            TitleDivider(
                                title: 'Siga nossas redes sociais',
                                actionTitle: null,
                                onTap: null),
                            SocialsCarousel()

                            // TitleDivider('Ranking de pontos',
                            //     actionTitle: "ver todos", onTap: () {
                            //   Get.toNamed(Routes.RANKING_TOP50);
                            // }),
                            // Obx(() => RankingTop3(
                            //     ranking: _controller
                            //         .rankingModelResult.value.ranking)),
                          ],
                        ),
                      );
                    else
                      return SecondBodyShimmer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Theme.of(context).primaryColor,
          systemNavigationBarColor: Theme.of(context).accentColor,
        ),
        child: Scaffold(
          backgroundColor: secondaryColor,
          body: Obx(
            () => ModalProgressHUD(
              inAsyncCall: _controller.loading.value,
              child: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () => _controller.refreshPage(),
                  child: Column(
                    children: [
                      Container(
                        child: singleChildScrollView,
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        height: 0.5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
