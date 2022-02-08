import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components.dart';

class ExclusivityList extends StatelessWidget {
  final ScoreController scoreController;
  final HomeController homeController;

  ExclusivityList(
      {required this.scoreController, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          ExclusivityItem(
            onTap: (heroTag) {
              Get.toNamed(Routes.CASHBACK, arguments: <String, dynamic>{
                "points": scoreController.scoreModelResult.value.customerLevel
                    ?.customerBalancePoints,
                "heroTag": heroTag,
                "homeController": homeController
              });
            },
            imageAsset: 'assets/images/gamification_icons/cashback_icon.png',
            title: 'Cashback',
            hasBorder: false,
            description: 'Troque seus Rubis por dinheiro',
            message: 'A partir de R\$ 10,00',
          )
        ],
      ),
    );
  }
}
