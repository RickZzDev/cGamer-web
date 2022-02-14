import 'dart:convert';

import 'package:cGamer/app/data/models/home_models/balance_model.dart';
import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_values_model.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_provider_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';

class PhoneRechargeValuesController extends GetxController {
  Rx<PhoneRechargeValuesModel> values = PhoneRechargeValuesModel().obs;

  var hasCompletedValuesRequest = false.obs;
  var hasCompletedBalanceRequest = false.obs;
  RxInt selectedValue = 0.obs;
  PhoneRechargeModel model = PhoneRechargeModel();
  BalanceModel balanceModel = BalanceModel();

  final PhoneProvidersRepository repository;
  final HomeRepository homeRepository;
  PhoneRechargeValuesController(
      {required this.repository, required this.homeRepository});

  var loading = false.obs;

  @override
  void onInit() {
    model = Get.arguments["phone_recharge_model"];
    super.onInit();
  }

  @override
  void onReady() {
    getValues();
    getBalance();
    super.onReady();
  }

  void changePage() {
    model.value = values.value.values?[selectedValue.value].amount;
    model.valueFormatted =
        values.value.values?[selectedValue.value].ammountFormatted;
    model.productId = values.value.values?[selectedValue.value].productId;
    Get.toNamed(Routes.RECHARGE_PHONE_CONFIRM,
        arguments: {'phone_recharge_model': model});
  }

  void setSelecteValue(int? value) => selectedValue.value = value ?? -1;

  getValues() async {
    loading.value = true;
    var response = await repository.getValues(model.provider?.name ?? "");
    if (ExceptionUtils.verifyIfIsException(response)) {
      hasCompletedValuesRequest.value = false;
      loading.value = false;
    } else {
      values.value = PhoneRechargeValuesModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      hasCompletedValuesRequest.value = true;
      loading.value = false;
    }
  }

  getBalance() async {
    var response = await homeRepository.getBalance();
    if (ExceptionUtils.verifyIfIsException(response)) {
      hasCompletedBalanceRequest.value = false;
    } else {
      balanceModel = BalanceModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      hasCompletedBalanceRequest.value = true;
    }
  }

  bool hasBalanceToRecharge() {
    double? valueRecharge =
        values.value.values?[selectedValue.value].amount ?? 0.0;
    String balanceString = balanceModel.balanceAvailable!.available!
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    double valueBalance = double.parse(balanceString);
    return valueRecharge <= valueBalance;
  }
}
