import 'dart:io';

import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner_slim.dart';
import 'package:cGamer/app/ui/components/play_to_win_components/subpages/lol_subpage/lol_subpage_grid.dart';
import 'package:cGamer/app/utils/admob/admob_util.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class LolSubPage extends StatelessWidget {
  final PlayToWinController controller;

  LolSubPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      controller.gameInfoModel != null &&
              (controller.gameInfoModel?.connected ?? false) &&
              !controller.isPrime
          ? ProBannerSlim(
              image:
                  "assets/images/play_to_win_games_images/playtowin-prime.png",
              title: "Libere mais partidas sendo Prime, assine já!")
          : Container(),
      Container(
        margin: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          children: [
            Text(
              'League of Legends',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 80,
              child: controller.gameInfoModel != null &&
                      (controller.gameInfoModel?.connected ?? false)
                  ? CustomRichText(
                      fontSize: 16.0,
                      textAlign: TextAlign.center,
                      normalText: 'Conta conectada!\n',
                      customText:
                          '${controller.gameInfoModel?.details?.gameNick}\n',
                      normalText2: 'Jogue diaramente para resgatar Rubis.',
                    )
                  : Text(
                      'Conecte sua conta do League of Legends \ne ganhe Rubis jogando!',
                      style: textStyle.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
            ),
            controller.gameInfoModel != null &&
                    (controller.gameInfoModel?.connected ?? false)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoLSubPageGrid(controller: controller),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text('Acumulado do dia: ',
                                          style: textStyle.copyWith(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              fontSize: 16))),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    'assets/images/gamification_icons/cristal.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    (controller.gameInfoModel?.details
                                                ?.rescueToday ??
                                            false)
                                        ? "Resgatado"
                                        : "${controller.pointsForRescue(controller.currentGame.value).formattedPoints()} Rubis",
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: primaryColor),
                              ))),
                      SizedBox(
                        height: 4,
                      ),
                      Obx(() => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: GenericButton(
                              enabled: controller.buttonIsEnabled(
                                  controller.currentGame.value),
                              text: (controller.gameInfoModel?.details
                                          ?.rescueToday ??
                                      false)
                                  ? 'Resgate diário realizado'
                                  : 'Resgatar Rubis',
                              txtColor: Colors.white,
                              onPressedFunction: () async {
                                if (controller.buttonIsEnabled(
                                    controller.currentGame.value)) {
                                  if (controller.isPrime) {
                                    await controller.rescuePoints();
                                  } else {
                                    controller.admobUtil
                                        ?.showRewardAd(((event) async {
                                      switch (event) {
                                        case RewardAdEvent.rewarded:
                                          controller.isAdRewarded.value = true;
                                          break;
                                        case RewardAdEvent.closed:
                                          if (controller.isAdRewarded.value) {
                                            await controller.rescuePoints();
                                            controller.isAdRewarded.value =
                                                false;
                                          }
                                          controller.admobUtil?.loadRewardAd();
                                          break;
                                        case RewardAdEvent.failed:
                                          controller.admobUtil?.loadRewardAd();
                                          controller.rescuePoints();
                                          break;
                                        default:
                                          break;
                                      }
                                    }));
                                  }
                                } else {
                                  SnackBarUtils.showSnackBar(
                                      desc: (controller.gameInfoModel?.details
                                                  ?.rescueToday ??
                                              false)
                                          ? 'Resgate diário já realizado, retorne amanhã para ganhar mais Rubis.'
                                          : 'Complete os jogos do dia, para liberar o botão de resgate.',
                                      title: 'Atenção',
                                      color: Colors.orange[400]);
                                }
                              }))),
                      SizedBox(
                        height: 8,
                      ),
                      controller.gameInfoModel?.details?.lastUpdate != null
                          ? Container(
                              width: screenWidthhSize,
                              child: Text(
                                'Última sincronização em ${controller.gameInfoModel?.details?.lastUpdate}',
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(
                                    fontSize: 14, color: Colors.white60),
                              ))
                          : Container(),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    Routes.MARKETPLACE_CONFIRM_TERMS_USE,
                                    arguments: {
                                      "title_terms": "Regulamento",
                                      "terms_use":
                                          "- Valido para qualquer formato de partida, basta jogar.\n\n- O botão Resgatar Rubis é liberado quando completar o mínimo de 5 partidas no dia.\n\n- Às 00hrs os jogos do dia são resetados, para que consiga acumular mais Rubis no próximo dia.\n\n- IMPORTANTE: Somente é permitido um resgate por dia, caso tente efetuar outro resgate no mesmo dia não irá conseguir."
                                    });
                              },
                              child: Text('Leia as regras',
                                  style: textStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline)))),
                    ],
                  )
                : Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/home_images/JB_Banner_LOL.jpg',
                          fit: BoxFit.cover,
                        ))),
          ],
        ),
      )
    ]);
  }
}
