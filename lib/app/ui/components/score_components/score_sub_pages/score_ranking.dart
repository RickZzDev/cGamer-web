import 'package:cGamer/app/controllers/score/ranking_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/my_ranking_title.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/ranking_my_position.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/ranking_title.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/ranking_top50.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ScoreRanking extends StatelessWidget {
  final RankingController rankingController = Get.find<RankingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: rankingController.loading.value,
        child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                appBarTxt: "Ranking geral",
              ),
            ),
            body: Obx(() => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: RefreshIndicator(
                    onRefresh: () => rankingController.onRefreshRankingView(),
                    child: SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // TitleDivider("Sua posição"),
                          rankingController.rankingModelResult.value
                                          .userRanking !=
                                      null &&
                                  rankingController.rankingModelResult.value
                                          .userRanking?.username !=
                                      null
                              ? Column(children: [
                                  MyRankingTitle(),
                                  RankingMyPosition(
                                      controller: rankingController)
                                ])
                              : Container(),
                          TitleDivider(title: "TOP 50"),
                          RankingTitle(),
                          RankingTop50(controller: rankingController),
                        ],
                      ),
                    ))))))));
  }
}
