import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/provider/bank_provider/bank_provider.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/bank_repository.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/bank_components/bank_grid.dart';
import 'package:cGamer/app/ui/components/bank_components/bank_header.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid_services.dart';
import 'package:cGamer/app/ui/components/home_components/home_title_divider_component.dart';
import 'package:cGamer/app/ui/components/home_components/ranking_top3/ranking_top3.dart';
import 'package:cGamer/app/ui/components/home_components/user_register_status.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BankPage extends StatefulWidget {
  BankPage(this.changeTab);
  final Function changeTab;

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  void initState() {
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    Requester client = Requester();

    BankApiClient _apiClient = BankApiClient(httpClient: client);
    final BankController _controller = Get.put(
      BankController(
        repository: BankRepository(apiClient: _apiClient),
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
                    _controller.hasCompletedHeaderRequest.value!,
                    _controller.hasCompletedBalanceRequest.value!,
                  ]),
                  builder: (context, AsyncSnapshot _snapshots) {
                    if (_snapshots.connectionState == ConnectionState.done)
                      return Obx(
                        () => BankHeader(
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
            Container(
              child: Obx(
                () => FutureBuilder(
                  future: Future.wait([
                    _controller.hasCompletedStatusRequest.value!,
                    _controller.hasCompletedBalanceRequest.value!,
                    _controller.hasCompletedHeaderRequest.value!,
                    _controller.hasCompletedExtractRequest.value!,
                    _controller.hasCompletedProfileRequest.value!,
                  ]),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshots) {
                    if (snapshots.connectionState == ConnectionState.done)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _controller.buildBankAccountComponent(),
                            BankGrid(controller: _controller),
                            SizedBox(
                              height: 16,
                            ),
                            TitleDivider(
                                title: 'Últimas movimentações',
                                actionTitle: "ver todas",
                                onTap: () {
                                  Get.toNamed(Routes.EXTRACT_PAGE);
                                }),
                            _controller.extractResult.value != null
                                ? Column(
                                    children: [
                                      _controller.listTransactionsIsEmpty(
                                              _controller.extractResult.value
                                                  .transactions)
                                          ? Align(
                                              alignment: Alignment.topLeft,
                                              child: EmptyTransaction(),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: (_controller
                                                              .extractResult
                                                              .value
                                                              .transactions
                                                              ?.length ??
                                                          0) >=
                                                      3
                                                  ? 3
                                                  : (_controller
                                                          .extractResult
                                                          .value
                                                          .transactions
                                                          ?.length ??
                                                      0),
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                onTap: () => _controller
                                                            .extractResult
                                                            .value
                                                            .transactions?[
                                                                index]
                                                            .details !=
                                                        null
                                                    ? _controller
                                                        .showExtractDetailsModel(
                                                            context,
                                                            transactionExtract:
                                                                _controller
                                                                    .extractResult
                                                                    .value
                                                                    .transactions?[index])
                                                    : DoNothingAction(),
                                                child: LastMovimentsComponent(
                                                  date: _controller
                                                      .extractResult
                                                      .value
                                                      .transactions?[index]
                                                      .date,
                                                  imgSrc: _controller
                                                          .extractResult
                                                          .value
                                                          .transactions?[index]
                                                          .iconUrl ??
                                                      "",
                                                  title: _controller
                                                      .extractResult
                                                      .value
                                                      .transactions?[index]
                                                      .title,
                                                  toName: _controller
                                                      .extractResult
                                                      .value
                                                      .transactions?[index]
                                                      .description,
                                                  amount: _controller
                                                      .extractResult
                                                      .value
                                                      .transactions?[index]
                                                      .amount
                                                      .toString(),
                                                  isLast: index ==
                                                      (_controller
                                                                  .extractResult
                                                                  .value
                                                                  .transactions
                                                                  ?.length ??
                                                              0) -
                                                          1,
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 16,
                            ),
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
