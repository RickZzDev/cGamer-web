import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class WithdrawCoinController extends GetxController {
  final CoinWalletRepository repository;
  WithdrawCoinController({required this.repository});
  late double mafaAmmount;

  Rx<bool> loading = false.obs;
  Rx<bool> shouldShowError = false.obs;
  Rx<String> taxValue = RxString("");
  TextEditingController walletIdController = TextEditingController();
  MoneyMaskedTextController mafaQuantityController =
      MoneyMaskedTextController();
  MoneyMaskedTextController taxValueController = MoneyMaskedTextController();
  double taxTransfer = 0.005;
  var isPrime = false.obs;

  void verifyIfHavaAmmount(
      {required double inputedAmmount, required double availableAmmount}) {
    double taxDouble = inputedAmmount * taxTransfer;
    taxValue.value = taxDouble.toPrecision(2).toString().replaceAll('.', ',');
    inputedAmmount + (inputedAmmount * taxTransfer) > availableAmmount
        ? shouldShowError.value = true
        : shouldShowError.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    mafaAmmount = Get.arguments['mafaAmmount'] ?? 0.0;
    isPrime.value = await PrimeUtils.isPrime();
    taxTransfer = isPrime.value ? 0.0 : taxTransfer;
  }

  void tapContinue() {
    double taxVal = double.parse(taxValue.value.replaceAll(',', '.'));
    String walletId = walletIdController.text;
    String quantityString = mafaQuantityController.text;
    double quantity = double.parse(quantityString.replaceAll(',', '.'));
    TransferReviewModel model = TransferReviewModel(
        walletId, quantityString, quantity, mafaAmmount.toString(), taxVal);

    Get.toNamed(Routes.WALLET_COIN_WITHDRAW_CONFIRM, arguments: {
      'model': model,
    });
  }
}
