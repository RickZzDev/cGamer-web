import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/trophy/earn_more_trophies.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/trophy/my_trophy_area.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/trophy/play_win_trophies.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner_slim.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ClanEarnTrophy extends StatelessWidget {
  final controller;
  final HomeController homeController;

  ClanEarnTrophy(this.controller, this.homeController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        body: RefreshIndicator(
            onRefresh: () => controller.getPlayWinTrophys(),
            child: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              color: secondaryColor,
              child: Column(
                children: [
                  homeController.isPrime
                      ? Container(
                          height: 16,
                        )
                      : ProBannerSlim(
                          title: "Reduza na metade o tempo das atividades!",
                        ),
                  TitleDivider(
                    title: "Meus troféus",
                    edgeInsets: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  ),
                  Obx(() => MyTrophyArea(
                        title: "Temporada atual",
                        qtdTrophy: controller
                            .playWinTrophyModel.value.balanceTrophy
                            .toString(),
                      )),
                  TitleDivider(title: "Jogue para ganhar troféus"),
                  PlayWinTrophies(controller),
                  TitleDivider(title: "Como ganhar mais troféus"),
                  EarnMoreTrophies(controller, homeController),
                ],
              ),
            ))));
  }
}
