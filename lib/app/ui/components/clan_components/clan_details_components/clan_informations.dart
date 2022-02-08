import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/clan_informations_emblem.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

import '../../components.dart';

class ClanInformations extends StatelessWidget {
  final controller;

  ClanInformations(this.controller);
  bool get userHasClan => controller.userHasClan;
  @override
  Widget build(BuildContext context) {
    //print(userHasClan);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClanInformationsEmblem(
                controller.detailsModel?.image ?? "",
                controller.isEditing.value,
                onChangeTap: controller.openEmblemModal,
              ),
              Row(children: [
                Image.asset(
                  'assets/images/gamification_icons/trophy.png',
                  height: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  controller.detailsModel?.qtdTrophy.toString() ?? "",
                  style: textStyle.copyWith(fontSize: 14),
                )
              ])
            ],
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      height: (controller.detailsModel?.isMember ?? false)
                          ? 100
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => controller.isEditing.value
                            ? DescriptionField(
                                textEditingController:
                                    controller.descriptionTextController!,
                                textSize: 14)
                            : SingleChildScrollView(
                                child: Text(
                                  controller.detailsModel?.description ??
                                      "Nenhuma descrição foi informada.",
                                  style: textStyle.copyWith(fontSize: 14),
                                ),
                              )),
                      )),
                  (controller.detailsModel?.isMember ?? false)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GenericButton(
                              text: 'Ver Ranking',
                              onPressedFunction: () {
                                Get.toNamed(Routes.CLAN_RANKING);
                              },
                              color: Colors.white.withOpacity(0.85),
                              txtColor: secondaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GenericButton(
                                txtColor: secondaryColor,
                                color: Colors.white.withOpacity(0.85),
                                text: 'Outras opções',
                                onPressedFunction: () {
                                  Get.toNamed(Routes.CLAN_INTERACTIONS,
                                      arguments: {
                                        "interactions": controller
                                                .detailsModel?.iterations ??
                                            [],
                                        "clanId": controller.clanId
                                      });
                                })
                          ],
                        )
                      : userHasClan
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: GenericButton(
                                  text: (controller.detailsModel?.isRequested ??
                                          false)
                                      ? 'Remover solicitação'
                                      : '  Solicitar entrada  ',
                                  onPressedFunction: () {
                                    // chamar servico para solicitar entrada no cla
                                    if (!(controller
                                            .detailsModel?.isRequested ??
                                        false)) {
                                      controller.requestEntry();
                                    } else {
                                      controller.leftCla();
                                    }
                                  },
                                  txtColor: secondaryColor,
                                  color: Colors.white.withOpacity(0.85),
                                  enabled:
                                      !(controller.detailsModel?.isRequested ??
                                          false),
                                )),
                              ],
                            )
                ])),
          )
        ],
      ),
    );
  }
}
