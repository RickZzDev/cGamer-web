import 'dart:convert';

import 'package:cGamer/app/data/models/recharge_phone/phone_provider_model.dart';
import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_provider_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneProvidersController extends GetxController {
  Rx<PhoneProvidersModel> providers = PhoneProvidersModel().obs;

  var hasCompletedProvidersRequest = false.obs;

  final PhoneProvidersRepository repository;
  PhoneProvidersController({required this.repository});

  var loading = false.obs;
  PhoneRechargeModel model = PhoneRechargeModel();

  @override
  void onInit() {
    model = Get.arguments["phone_recharge_model"];
    super.onInit();
  }

  @override
  void onReady() {
    getProviders();
    super.onReady();
  }

  void changePage(PhoneProvider? provider) {
    model.provider = provider;
    Get.toNamed(Routes.RECHARGE_PHONE_VALUES,
        arguments: {'phone_recharge_model': model});
  }

  getProviders() async {
    loading.value = true;
    var response = await repository.getProviders();
    if (ExceptionUtils.verifyIfIsException(response)) {
      hasCompletedProvidersRequest.value = false;
      loading.value = false;
    } else {
      providers.value = PhoneProvidersModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      hasCompletedProvidersRequest.value = true;
      loading.value = false;
    }
  }
}
