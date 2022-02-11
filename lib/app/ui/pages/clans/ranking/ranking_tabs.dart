import 'package:cGamer/app/controllers/clan_controllers/clan_ranking_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/pages/clans/ranking/ranking_clans.dart';
import 'package:cGamer/app/ui/pages/clans/ranking/ranking_members.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClanRankingTabsPage extends StatefulWidget {
  @override
  _ClanRankingTabsPageState createState() => _ClanRankingTabsPageState();
}

class _ClanRankingTabsPageState extends State<ClanRankingTabsPage> {
  final controller = Get.find<ClanRankingController>();

  @override
  Widget build(BuildContext context) {
    final double appBarSize = 60;

    return Container(
        color: secondaryColor,
        child: DefaultTabController(
            length: controller.tabs?.length ?? 0,
            child: Scaffold(
                backgroundColor: secondaryColor,
                appBar: PreferredSize(
                    child: CustomAppBar(
                      appBarTxt: "Ranking",
                    ),
                    preferredSize: Size.fromHeight(appBarSize)),
                body: Container(
                  height: screenHeigthSize - appBarSize,
                  child: Column(
                    children: [
                      Expanded(
                        child: Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: AppBar(
                                elevation: 4,
                                bottom: TabBar(
                                    indicatorColor: primaryColor,
                                    indicatorWeight: 4,
                                    tabs: controller.tabs!),
                              ),
                            ),
                            body: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  // Container(),
                                  // Container()
                                  RankingClans(controller),
                                  RankingMembers(controller),
                                ])),
                      )
                    ],
                  ),
                ))));
  }
}
