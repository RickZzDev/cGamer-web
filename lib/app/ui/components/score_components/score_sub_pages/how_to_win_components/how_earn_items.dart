import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/how_to_win_components/how_to_win_card.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:get/get.dart';

class HowToEarnItems extends StatelessWidget {
  final HowEarnModel model;
  final ScoreController _controller;
  final HomeController homeController;

  HowToEarnItems(this.homeController, this.model, this._controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.howEarns?.length ?? 0,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HowToWinCard(
                      isPrime: _controller.isPrime,
                      imgSrc: model.howEarns?[index].iconUrl,
                      text: model.howEarns?[index].title,
                      description: model.howEarns?[index].description,
                      hasBorder: index == (model.howEarns?.length ?? 0) - 1
                          ? false
                          : true,
                      earnPoints: model.howEarns?[index].earnPoints
                          ?.replaceAll('ponto', 'Rubi'),
                      onTap: () =>
                          _actionVerifier(model.howEarns?[index].action)),
                )),
      ],
    );
  }

  dynamic _actionVerifier(String? action) async {
    switch (action) {
      case "TASKS_OFFERS":
        await _controller.showOfferWall();
        break;
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
      case "GAMER_STORE":
        Get.toNamed(Routes.MARKETPLACE);
        break;
      case "SHOW_AD":
        await _controller.showAd();
        break;
      case "PARTNERS":
        await _controller.showPartners();
        break;
      default:
        break;
    }
  }
}
