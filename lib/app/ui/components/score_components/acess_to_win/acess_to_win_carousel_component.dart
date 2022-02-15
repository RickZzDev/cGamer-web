import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AcessToWinCarousel extends StatelessWidget {
  AcessToWinCarousel({required this.controller});
  final ScoreController? controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        width: MediaQuery.of(context).size.width,
        height: 115,
        margin: EdgeInsets.only(bottom: 24),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          itemBuilder: (context, index) {
            if (controller?.indexCurrentDay == -1 &&
                !(controller?.daysModelResult.value.days?[index].checked ??
                    false)) {
              controller?.indexCurrentDay = index;
            }

            return AcessToWinCard(
              dayCount:
                  controller?.daysModelResult.value.days?[index].title ?? "",
              hasCompleted:
                  (controller!.daysModelResult.value.days?[index].checked ??
                      false),
              moreScore: controller?.daysModelResult.value.days?[index].points
                      .formattedPoints() ??
                  "",
              currentDay: controller?.indexCurrentDay == index ? true : null,
              onTap: controller?.indexCurrentDay == index
                  ? () {
                      controller?.checkInDaily(
                          controller?.daysModelResult.value.days?[index].id ??
                              0);
                    }
                  : null,
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 12,
          ),
          itemCount: controller!.daysModelResult.value.days?.length ?? 0,
        )));
  }
}
