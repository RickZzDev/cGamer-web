import 'package:cGamer/app/controllers/main_page_holder/page_holder_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/pages/bank/bank_view.dart';
import 'package:cGamer/app/ui/pages/coin_wallet/coin_wallet.dart';
import 'package:cGamer/app/ui/pages/home/home_view.dart';
import 'package:cGamer/app/ui/pages/pages.dart';
import 'package:cGamer/app/ui/pages/score/score_view.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPagesHolder extends StatelessWidget {
  final PagesHolderController _controller = Get.find<PagesHolderController>();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      // HomePage(_controller.changeIndex),
      CoinWallet(),
      // ScoreView(),
      // BankPage(_controller.changeIndex),
      ProfileView()
    ];
    return WillPopScope(
      onWillPop: () => ExitConfirmation.exitConfirmation(context)!,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomNavigationBar: Obx(
          () => CustomBottomNavigation(
            index: _controller.currentIndex.value,
            changeIndex: _controller.changeIndex,
          ),
        ),
        body: Obx(
          () => SafeArea(
            child: pages[_controller.currentIndex.value],
          ),
        ),
      ),
    );
  }
}
