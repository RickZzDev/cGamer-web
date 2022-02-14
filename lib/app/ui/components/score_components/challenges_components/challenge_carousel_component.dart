import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/score_components/challenges_components/challenge_card.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/navigation/deep_link_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengesCarousel extends StatelessWidget {
  ChallengesCarousel({required this.controller, required this.homeController});
  final ScoreController controller;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 24),
        child: Obx(() => ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              itemBuilder: (context, index) {
                return ChallengeCard(
                  title: controller
                      .challengesModelResult.value.challenges?[index].title,
                  description: controller.challengesModelResult.value
                      .challenges?[index].description,
                  imagePath: controller
                      .challengesModelResult.value.challenges?[index].imagePath,
                  points: controller
                      .challengesModelResult.value.challenges?[index].points,
                  hasCompleted: controller.challengesModelResult.value
                          .challenges?[index].hasCompleted ??
                      false,
                  infoTap: () {
                    controller.showAlertInfo(controller
                        .challengesModelResult.value.challenges?[index].info);
                  },
                  onTap: !(controller.challengesModelResult.value
                              .challenges?[index].hasCompleted ??
                          false)
                      ? () {
                          homeController.statusRegisterResult.value
                                      .statusBanlky ==
                                  "APPROVED"
                              ? DeepLinkUtils(homeController.changeTab!)
                                  .defineDeepLink(controller
                                          .challengesModelResult
                                          .value
                                          .challenges?[index]
                                          .deepLink ??
                                      "")
                              : SnackBarUtils.showSnackBar(
                                  desc:
                                      "Para acessar é necessário ativar sua conta.",
                                  title: "Atenção",
                                  color: Colors.orange[400],
                                  icon: Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ));
                        }
                      : null,
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 12,
              ),
              itemCount:
                  controller.challengesModelResult.value.challenges?.length ??
                      0,
            )));
  }
}
