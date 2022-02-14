import 'package:cGamer/app/controllers/score/ranking_controller.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/ranking_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingMyPosition extends StatelessWidget {
  RankingMyPosition({required this.controller});

  final RankingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 16),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(() => UserRanking(
                  user: controller.rankingModelResult.value.userRanking,
                  isMyPosition: true,
                  position: 0,
                ));
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 0,
          ),
          itemCount: 1,
        ));
  }
}
