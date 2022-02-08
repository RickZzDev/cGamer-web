import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class BuyCoinController extends GetxController {
  final CoinWalletRepository repository;
  BuyCoinController({required this.repository});

  var loading = false.obs;
  //MaskedTextController moneyController = MaskedTextController(mask: '00000.00');
  MoneyMaskedTextController moneyController = MoneyMaskedTextController();
  MoneyMaskedTextController coinController = MoneyMaskedTextController();
  var valueCoin = 0.0.obs;
  Rx<MafaBalanceModel> model = MafaBalanceModel().obs;
  var messageError = "".obs;
  var checkBoxValue = false.obs;

  void setCheckBox(value) => this.checkBoxValue.value = value;

  @override
  void onInit() async {
    super.onInit();
    await getCurrencyValue();
  }

  Future<void> getCurrencyValue() async {
    loading.value = true;

    try {
      var response = await repository.getMafaBalance();
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
          desc: 'Algo deu errado... tente novamente mais tarde! :(',
          title: "Ops...",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
      }

      valueCoin.value = response.currentCoinValue;
      model.value = response;

      if (model.value.currentCoinValue == -1) {
        SnackBarUtils.showSnackBar(
            desc:
                'Não foi possível buscar a cotação, tente novamente mais tarde!',
            title: "Ops...",
            color: Colors.orange[400]);
      }
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
        desc: 'Algo deu errado... tente novamente mais tarde! :(',
        title: "Ops...",
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
      return;
    }
  }

  calculateGGCToBRL(String value) {
    messageError.value = "";
    String ggcString = value.trim();
    if (ggcString == "" ||
        (ggcString.contains(',') && ggcString.split(',').length > 2)) {
      moneyController.text = "0.00";
      return;
    } else {
      double ggc =
          double.parse(ggcString.replaceAll('.', '').replaceAll(",", "."));
      var moneyValue = (ggc.toPrecision(2) * valueCoin.value).toPrecision(2);
      // var decimals = ggcString.split(',')[1];
      // double ggc =
      //     double.parse(ggcString.replaceAll('.', '').replaceAll(",", "."));
      // //  var decimals = ggc.toString().split('.')[1];
      // double moneyValue = 0.00;
      // if (decimals.length >= 2) {
      //   if (decimals.length >= 2) {
      //     decimals = decimals.substring(0, 2);
      //     ggcString = ggc.toString().split(".")[0] + "," + decimals;
      //     ggc = double.parse(ggcString.replaceAll(",", "."));
      //     coinController.text = ggcString;
      //   }
      //   int val = int.parse(decimals.split('')[1]);
      //   if (val > 2) {
      //     moneyValue = ((ggc * (valueCoin * 10)) + 0.01).toPrecision(2);
      //   } else {
      //     moneyValue = (ggc * (valueCoin * 10)).toPrecision(2);
      //   }
      // } else {
      //   moneyValue = (ggc * (valueCoin * 10)).toPrecision(2);
      // }

      var decimals = "$moneyValue".split('.')[1];
      if (decimals.length == 1) {
        moneyController.text = "${moneyValue}0";
      } else {
        moneyController.text = "$moneyValue";
      }
    }
  }

  calculateBRLToGGC() {
    messageError.value = "";
    String moneyString = moneyController.text.trim();
    if (moneyString == "" ||
        (moneyString.contains(',') && moneyString.split(',').length > 2)) {
      coinController.text = "0";
      return;
    } else {
      double money =
          double.parse(moneyString.replaceAll('.', '').replaceAll(",", "."));

      double moneyValue = 0.00;
      moneyValue = (money / valueCoin.value).toPrecision(2);

      // if (decimals.length > 2) {
      //   if (decimals.length > 2) {
      //     decimals = decimals.substring(0, 2);
      //     moneyString = money.toString().split(".")[0] + "," + decimals;
      //     money = double.parse(moneyString.replaceAll(",", "."));
      //     coinController.text = moneyString;
      //   }
      //   int val = int.parse(decimals.split('')[2]);
      //   if (val > 5) {
      //     moneyValue = (((money / (valueCoin)) * 10) + 0.01).toPrecision(2);
      //   } else {
      //     moneyValue = ((money / (valueCoin)) * 10).toPrecision(2);
      //   }
      // } else {
      //   moneyValue = ((money / (valueCoin)) * 10).toPrecision(2);
      // }

      // var decimals = "$moneyValue".split('.')[1];
      var decimals = moneyValue.toString().split('.')[1];
      if (decimals.length == 1 && money > 0.1) {
        coinController.text = "${moneyValue}0";
      } else {
        coinController.text = "$moneyValue";
      }

      // coinController.text = "${moneyValue.toPrecision(2)}".replaceAll(".", ",");
    }
  }

  void tapContinue() {
    if (model.value.currentCoinValue == -1) {
      SnackBarUtils.showSnackBar(
          desc:
              'Não foi possível buscar a cotação, tente novamente mais tarde!',
          title: "Ops...",
          color: Colors.orange[400]);
      return;
    }

    String moneyString = moneyController.text.trim();
    if (moneyString == "" ||
        (moneyString.contains(',') && moneyString.split(',').length > 2)) {
      coinController.text = "0";
      messageError.value = "Valor mínimo para compra de R\$ 50,00";
      return;
    } else {
      double money =
          double.parse(moneyString.replaceAll('.', '').replaceAll(",", "."));
      if (money < 50) {
        messageError.value = "Valor mínimo para compra de R\$ 50,00";
        SnackBarUtils.showSnackBar(
            desc: 'Valor mínimo para compra é de R\$ 50,00',
            title: 'Atenção',
            color: Colors.orange[400]);
        return;
      } else {
        double totalValue = money;

        var totalCoinsString = coinController.text.trim();
        double totalCoins = double.parse(
            totalCoinsString.replaceAll('.', '').replaceAll(",", "."));

        messageError.value = "";
        Get.toNamed(Routes.WALLET_CONFIRM_BUY_COIN,
            arguments: {'totalValue': totalValue, 'totalCoins': totalCoins});
      }
    }
  }
}
