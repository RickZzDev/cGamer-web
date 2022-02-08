import 'package:cGamer/app/controllers/score/my_badges/my_badge_controller.dart';
import 'package:cGamer/app/ui/components/score_components/my_badges/my_badge_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyBadgesList extends StatelessWidget {
  MyBadgesList({required this.controller});

  final MyBadgeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 24),
        child: Obx(() => ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(bottom: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Obx(() => MyBadgeItem(
                      title: "Sem badge",
                      description:
                          "Seu espaço de badge fica em branco quando utiliza desta opção.",
                      imagePath: "https://svgshare.com/i/VSa.svg",
                      isSvg: true,
                      isSelected: controller.idBadgeSelected.value == 0
                          ? controller.badgesResult.value.badges == null ||
                              controller.badgesResult.value.badges?.length ==
                                  0 ||
                              !controller.containsActive.value
                          : controller.idBadgeSelected.value == -1,
                      onTap: () {
                        controller.setBadgeSelected(-1);
                      },
                    ));
              } else {
                return Obx(() => MyBadgeItem(
                      title: controller
                          .badgesResult.value.badges?[index - 1].title,
                      description: controller
                          .badgesResult.value.badges?[index - 1].description,
                      imagePath: controller
                          .badgesResult.value.badges?[index - 1].image,
                      isSelected: controller.idBadgeSelected.value == 0
                          ? (controller.badgesResult.value.badges?[index - 1]
                                  .isActive ??
                              false)
                          : controller.idBadgeSelected.value ==
                              controller
                                  .badgesResult.value.badges?[index - 1].id,
                      onTap: () {
                        controller.setBadgeSelected(controller
                                .badgesResult.value.badges?[index - 1].id ??
                            -1);
                      },
                    ));
              }
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
            itemCount: controller.badgesResult.value.badges != null
                ? (controller.badgesResult.value.badges?.length ?? 0) + 1
                : 1)));
  }
}
