import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/ui/components/score_components/trade_points/buy_customize_account_list_component.dart';

import 'package:flutter/material.dart';

import '../../components.dart';

class TradePoints extends StatelessWidget {
  TradePoints({required this.scoreController, required this.homeController});
  final ScoreController scoreController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => scoreController.onRefreshEarnView(),
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleDivider(title: "Exclusividade Jogga"),
              ExclusivityList(
                scoreController: scoreController,
                homeController: homeController,
              ),
              TitleDivider(title: "Gift Cards"),
              GiftCardsGrid(
                  scoreController.giftCardResult.value, scoreController),
              TitleDivider(title: "Personalize sua conta"),
              BuyCustomizeAccountList(
                scoreController: scoreController,
              ),

              //ExclusiveProductsGrid(), //Remove files
            ],
          ),
        )));
  }
}
