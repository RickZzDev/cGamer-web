import 'package:cGamer/app/controllers/score/ranking_controller.dart';
import 'package:cGamer/app/ui/components/score_components/ranking/ranking_user.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingTop50 extends StatelessWidget {
  RankingTop50({required this.controller});

  final RankingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 16),
        child: Obx(() => ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Obx(() => Column(children: [
                      UserRanking(
                        user:
                            controller.rankingModelResult.value.ranking?[index],
                        isMyPosition: false,
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
              itemCount:
                  controller.rankingModelResult.value.ranking?.length ?? 0,
            )));
  }
}
