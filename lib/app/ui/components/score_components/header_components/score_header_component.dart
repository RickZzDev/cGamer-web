import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class ScoreHeader extends StatelessWidget {
  ScoreHeader({required this.controller});

  final ScoreController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // ClipRRect(
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //     child: Image.asset(
      //       'assets/images/gamification_icons/background_levels.png',
      //       fit: BoxFit.cover,
      //       height: 130,
      //       cacheHeight:
      //           (130 * MediaQuery.of(context).devicePixelRatio).round(),
      //       cacheWidth: (MediaQuery.of(context).size.width *
      //               MediaQuery.of(context).devicePixelRatio)
      //           .round(),
      //       width: MediaQuery.of(context).size.width,
      //     )),
      Container(
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, bottom: 16, top: 24),
              // height: 141,
              //color: Colors.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            //Get.toNamed(Routes.MY_PROGRESS);
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Container(
                                  //   height: 85,
                                  //   width: 85,
                                  //   decoration: BoxDecoration(
                                  //     color: primaryColor,
                                  //     borderRadius: BorderRadius.all(
                                  //       Radius.circular(
                                  //         50,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Color(0xFF10AF26),
                                  //       borderRadius: BorderRadius.all(
                                  //         Radius.circular(
                                  //           50,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     margin: EdgeInsets.all(
                                  //       6,
                                  //     ),
                                  //   ),
                                  // ),
                                  Image.asset(
                                    'assets/images/gamification_icons/cristal.png',
                                    height: 80,
                                    width: 80,
                                  ),
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(100),
                                  //   child: CachedNetworkImage(
                                  //     imageUrl: controller
                                  //             .scoreModelResult
                                  //             .value
                                  //             .customerLevel
                                  //             ?.iconLevelUrl ??
                                  //         "",
                                  //     placeholder: (context, url) =>
                                  //         CircularProgressIndicator(),
                                  //     errorWidget: (context, url, error) =>
                                  //         Icon(
                                  //       Icons.error,
                                  //       color: primaryColor,
                                  //     ),
                                  //     height: 90,
                                  //     width: 90,
                                  //     cacheKey: controller
                                  //             .scoreModelResult
                                  //             .value
                                  //             .customerLevel
                                  //             ?.iconLevelUrl ??
                                  //         "",
                                  //     useOldImageOnUrlChange: true,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              // Row(children: [
                              //   Obx(
                              //     () => Text(
                              //       controller.scoreModelResult.value
                              //               .customerLevel?.customerLevel ??
                              //           "",
                              //       style: textStyle.copyWith(fontSize: 15),
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     width: 4,
                              //   ),
                              //   Icon(Icons.open_in_new,
                              //       size: 16, color: Colors.white),
                              // ]),
                            ],
                          )),
                      SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saldo disponível",
                              style: textStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image.asset(
                                  //   'assets/images/gamification_icons/cristal.png',
                                  //   height: 24,
                                  //   width: 24,
                                  // ),
                                  // SizedBox(
                                  //   width: 4,
                                  // ),
                                  Obx(() => Text(
                                        "${controller.scoreModelResult.value.customerLevel?.customerBalancePoints.formattedPoints()} Rubis",
                                        style: textStyle.copyWith(
                                            fontSize: 22,
                                            color: Color(0xffe87187),
                                            fontWeight: FontWeight.bold),
                                      )),
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Saldo pendente: ",
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/gamification_icons/cristal.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Obx(() => Text(
                                        "${controller.scoreModelResult.value.customerLevel?.customerPendentPoints.formattedPoints()} Rubis",
                                        style: textStyle.copyWith(
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.showAlertInfo(
                                          'Rubis pendentes podem levar de 15 a 60 dias para entrar como disponível, pois precisam de aprovação dos nossos parcerios para serem creditados.');
                                    },
                                    child: Icon(Icons.info_outline,
                                        size: 16, color: Colors.white),
                                  )
                                ]),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total acumulado: ",
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/gamification_icons/cristal.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Obx(() => Text(
                                        "${controller.scoreModelResult.value.customerLevel?.customerPoints.formattedPoints()} Rubis",
                                        style: textStyle.copyWith(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.showAlertInfo(
                                          'Aqui é o total acumulado de Rubis que você já conseguiu por aqui. Ele é utilizado para contabilizar sua posição no ranking. Lembrando que Rubis pendentes, não entram no acumulado, ok?  ');
                                    },
                                    child: Icon(Icons.info_outline,
                                        size: 16, color: Colors.white),
                                  )
                                ]),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
