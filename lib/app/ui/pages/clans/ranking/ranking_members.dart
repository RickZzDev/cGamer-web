import 'package:cGamer/app/controllers/clan_controllers/clan_ranking_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/clan_ranking_item.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/clan_ranking_title.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/clan_season_title.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/member_ranking_item.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/member_season_title.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/ranking/members_ranking_title.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RankingMembers extends StatelessWidget {
  final ClanRankingController controller;

  RankingMembers(this.controller);
  // final controller = Get.find<ClanRankingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading,
        child: Scaffold(
            backgroundColor: secondaryColor,
            body: RefreshIndicator(
                onRefresh: () => controller.onRefreshMembersRankingView(),
                child: SingleChildScrollView(
                    child: Container(
                        child: Column(children: [
                  controller.membersModelResult.value.season != null
                      ? MemberSeasonTitle(controller: controller)
                      : Container(),
                  SizedBox(height: 16),
                  TitleDivider(title: "TOP 30"),
                  MembersRankingTitle(),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Obx(() => ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return Obx(() => Column(children: [
                                    MemberRankingItem(
                                      isOWnCla:
                                          controller.clanInfoModel?.clanId ==
                                              controller.membersModelResult
                                                  .value.members?[index].claId,
                                      userHasClan:
                                          controller.clanInfoModel?.clanId !=
                                              null,
                                      member: controller.membersModelResult
                                          .value.members?[index],
                                      position: index + 1,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: primaryColor,
                                    ),
                                  ]));
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 0,
                            ),
                            itemCount: controller
                                    .membersModelResult.value.members?.length ??
                                0,
                          )))
                ])))))));
  }
}
