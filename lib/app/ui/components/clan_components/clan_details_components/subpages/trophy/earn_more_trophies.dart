import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/how_to_win_components/how_to_win_card.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:get/get.dart';

class EarnMoreTrophies extends StatelessWidget {
  final ClanDetailsController _controller;
  final HomeController homeController;
  EarnMoreTrophies(this._controller, this.homeController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _controller.howEarnTrophyModels.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HowToWinCard(
                      isTrophy: true,
                      imgSrc: _controller.howEarnTrophyModels[index].iconUrl,
                      text: _controller.howEarnTrophyModels[index].title,
                      description:
                          _controller.howEarnTrophyModels[index].description,
                      hasBorder:
                          index == _controller.howEarnTrophyModels.length - 1
                              ? false
                              : true,
                      earnPoints:
                          _controller.howEarnTrophyModels[index].earnPoints,
                      onTap: () => _actionVerifier(
                          _controller.howEarnTrophyModels[index].action)),
                )),
      ],
    );
  }

  dynamic _actionVerifier(String? action) async {
    switch (action) {
      case "INVITE_FRIEND":
        Get.toNamed(Routes.INVITE_FRIEND);
        break;
      case "RECHARGE_PHONE":
        homeController.statusRegisterResult.value.statusBanlky == "APPROVED"
            ? Get.toNamed(Routes.RECHARGE_PHONE_NUMBER)
            : SnackBarUtils.showSnackBar(
                color: Colors.orange[400],
                desc: "Para acessar é necessário ativar sua conta",
                title: "Atenção.");
        break;
      case "PAY_BILL":
        homeController.statusRegisterResult.value.statusBanlky == "APPROVED"
            ? Get.toNamed(Routes.PAYMENT_READ_BAR_CODE)
            : SnackBarUtils.showSnackBar(
                color: Colors.orange[400],
                desc: "Para acessar é necessário ativar sua conta",
                title: "Atenção.");

        break;
      case "SHOW_AD":
        await _controller.showAd();
        break;
      default:
        break;
    }
  }
}
