import 'package:cGamer/app/controllers/score/buy_badge/buy_badge_controller.dart';
import 'package:cGamer/app/ui/components/score_components/buy_badges/buy_badge_item.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BuyBadgesList extends StatelessWidget {
  BuyBadgesList({required this.controller});

  final BuyBadgeController controller;

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
              return Obx(() => BuyBadgeItem(
                    title: controller.badgesResult.value.badges?[index].title ??
                        "",
                    description: controller
                        .badgesResult.value.badges?[index].description,
                    imagePath:
                        controller.badgesResult.value.badges?[index].image,
                    sellPoints:
                        controller.badgesResult.value.badges?[index].sellPoints,
                    isSelected: controller.idBadgeSelected.value ==
                        controller.badgesResult.value.badges?[index].id,
                    hasContains: controller
                            .badgesResult.value.badges?[index].hasContains ??
                        false,
                    onTap: () {
                      if (controller
                              .badgesResult.value.badges?[index].hasContains ??
                          false) {
                        SnackBarUtils.showSnackBar(
                            desc:
                                "Você já adquiriu esse badge, para ativar acesse Meus Badges no seu Perfil.",
                            title: "Atenção");
                      } else {
                        controller.setBadgeSelected(
                            controller.badgesResult.value.badges?[index].id ??
                                0);
                      }
                    },
                  ));
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
            itemCount: controller.badgesResult.value.badges?.length ?? 0)));
  }
}
