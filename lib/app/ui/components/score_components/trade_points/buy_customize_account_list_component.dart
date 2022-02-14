import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/score_components/trade_points/buy_customize_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

// ignore: must_be_immutable
class BuyCustomizeAccountList extends StatefulWidget {
  BuyCustomizeAccountList({required this.scoreController});

  final ScoreController scoreController;

  @override
  _BuyCustomizeAccountListState createState() =>
      _BuyCustomizeAccountListState();
}

class _BuyCustomizeAccountListState extends State<BuyCustomizeAccountList> {
  var gCoins;

  @override
  void initState() {
    gCoins =
        "${widget.scoreController.scoreModelResult.value.customerLevel?.customerBalancePoints.formattedPoints()}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BuyCustomizeAccount> buttons = [
      BuyCustomizeAccount(
        title: "Troque a cor do seu @",
        description: "Se destaque, seja diferente.",
        imagePath: "assets/images/tab_bar_icons/Perfil.svg",
        onTap: () {
          Get.toNamed(Routes.CUSTOMIZATION);
        },
      ),
      BuyCustomizeAccount(
        title: "Adquira badges bem legais",
        description: "Complete sua coleção",
        imagePath: "assets/images/gamification_icons/icon_badges.svg",
        onTap: () {
          Get.toNamed(Routes.BUY_BADGES, arguments: {
            "gCoins":
                "${widget.scoreController.scoreModelResult.value.customerLevel?.customerBalancePoints.formattedPoints()}"
          });
        },
      ),
    ];

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 24),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            itemBuilder: (context, index) {
              return buttons[index];
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
            itemCount: buttons.length));
  }
}
