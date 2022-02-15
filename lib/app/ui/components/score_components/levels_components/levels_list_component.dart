import 'package:cGamer/app/controllers/profile/my_progress/my_progress_controller.dart';
import 'package:cGamer/app/ui/components/score_components/levels_components/level_card_component.dart';
import 'package:cGamer/app/ui/components/score_components/levels_components/start_level_component.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelsListComponent extends StatelessWidget {
  LevelsListComponent({required this.controller});
  final MyProgressController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 24, bottom: 24),
        child: Obx(() => ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              itemBuilder: (context, index) {
                if (index ==
                    (controller.levelsResult.value.levels?.length ?? 0)) {
                  return StartLevelCard();
                }

                int length =
                    (controller.levelsResult.value.levels?.length ?? 0) - index;
                return LevelsCard(
                  level: controller.levelsResult.value.levels?[length - 1]
                          .customerLevel ??
                      "",
                  multiplyPointsText: controller.levelsResult.value
                          .levels?[length - 1].multiplyPointsText ??
                      "",
                  imagePath: controller
                          .levelsResult.value.levels?[length - 1].iconUrl ??
                      "",
                  unlocked: controller
                          .levelsResult.value.levels?[length - 1].unlocked ??
                      false,
                  points: controller.levelsResult.value.levels?[length - 1]
                          .customerPoints ??
                      0,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 0,
              ),
              itemCount: controller.levelsResult.value.levels != null
                  ? (controller.levelsResult.value.levels?.length ?? 0) + 1
                  : 0,
            )));
  }
}
