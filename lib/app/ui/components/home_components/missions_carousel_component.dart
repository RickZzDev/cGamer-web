import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/navigation/deep_link_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MissionsCarousel extends StatelessWidget {
  const MissionsCarousel({
    Key? key,
    required HomeController controller,
    required ScoreController scoreController,
  })  : _controller = controller,
        _scoreController = scoreController,
        super(key: key);

  final HomeController _controller;

  final ScoreController _scoreController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 135,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 12,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount:
                  _scoreController.missionsResult.value.missions?.length ?? 0,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              itemBuilder: (context, index) {
                return Obx(
                  () => MissionCard(
                    hasBorder: true,
                    missions:
                        _scoreController.missionsResult.value.missions?[index],
                    onTapFunction: () => _controller
                                .statusRegisterResult.value.statusBanlky ==
                            "APPROVED"
                        ? (_scoreController.missionsResult.value
                                    .missions?[index].hasComplete ==
                                false)
                            ? DeepLinkUtils(_controller.changeTab!)
                                .defineDeepLink(_scoreController.missionsResult
                                        .value.missions?[index].deepLink ??
                                    "")
                            : null
                        : SnackBarUtils.showSnackBar(
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            ),
                            desc: "Para acessar é necessário ativar sua conta.",
                            title: "Atenção",
                            color: Colors.orange[400],
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
