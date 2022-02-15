import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/missions_carousel_component.dart';
import 'package:cGamer/app/ui/components/score_components/acess_to_win/acess_to_win_carousel_component.dart';
import 'package:cGamer/app/ui/components/score_components/challenges_components/challenge_carousel_component.dart';
import 'package:cGamer/app/ui/components/score_components/challenges_divider.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/how_to_win_components/how_earn_items.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HowToWin extends StatefulWidget {
  const HowToWin(
      {Key? key, required this.scoreController, required this.homeController})
      : super(key: key);
  final ScoreController scoreController;
  final HomeController homeController;

  @override
  _HowToWinState createState() => _HowToWinState();
}

class _HowToWinState extends State<HowToWin> {
  @override
  void initState() {
    widget.scoreController.onRefreshEarnView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => widget.scoreController.onRefreshEarnView(),
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AcessToWinDivider(),
              AcessToWinCarousel(
                controller: widget.scoreController,
              ),
              TitleDivider(title: "Ganhe mais Rubis"),
              Obx(() => HowToEarnItems(
                  widget.homeController,
                  widget.scoreController.howEarnModel.value,
                  widget.scoreController)),
              SizedBox(
                height: 20,
              ),
              ScoreMissionsDivider(),
              MissionsCarousel(
                  controller: widget.homeController,
                  scoreController: widget.scoreController),
              ChallengesDivider(),
              ChallengesCarousel(
                controller: widget.scoreController,
                homeController: widget.homeController,
              ),
            ],
          ),
        )));
  }
}
