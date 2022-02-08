import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class SuccessBuyCoinController extends GetxController {
  final CoinWalletRepository repository;
  SuccessBuyCoinController({required this.repository});

  double totalCoins = 0;
  double totalValue = 0;
  MoneyMaskedTextController moneyController = MoneyMaskedTextController();
  MoneyMaskedTextController taxController = MoneyMaskedTextController();
  MoneyMaskedTextController totalController = MoneyMaskedTextController();
  MoneyMaskedTextController coinController = MoneyMaskedTextController();
  String authorizationCode = "";
  var loading = false.obs;

  @override
  void onInit() async {
    totalCoins = Get.arguments['totalCoins'];
    totalValue = Get.arguments['totalValue'];
    authorizationCode = Get.arguments['authorizationCode'];
    moneyController = MoneyMaskedTextController(
      initialValue: totalValue,
    );
    coinController = MoneyMaskedTextController(
      initialValue: totalCoins,
    );
    double tax = totalValue * (2 / 100);
    taxController = MoneyMaskedTextController(
      initialValue: tax,
    );
    totalController = MoneyMaskedTextController(
      initialValue: totalValue + tax,
    );

    super.onInit();
  }

  void tapFinish() {
    //chamar notification para atualizar saldo em MAFA
    Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
  }
}
