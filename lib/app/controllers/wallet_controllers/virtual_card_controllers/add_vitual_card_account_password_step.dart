import 'dart:convert';

import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VirtualCardAccountPassowordController extends GetxController {
  final CardRepository repository;
  VirtualCardAccountPassowordController({required this.repository});

  TextEditingController passwordController = TextEditingController();
  String origin = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  VirtualCardRequestModel model = VirtualCardRequestModel();
  Rx<PCIVirtualCardModel> pciModel = PCIVirtualCardModel().obs;
  final loading = false.obs;

  @override
  void onInit() {
    origin = Get.arguments != null ? Get.arguments["origin"] : "";
    model = Get.arguments['card_request'];
    super.onInit();
  }

  dynamic validatePassword(String _txt) {
    if (_txt.isEmpty) {
      return "Favor preencher com a senha da sua conta";
    }

    return null;
  }

  dynamic validateCardPassword(String _txt) {
    if (_txt.length > 4) {
      return "Sua senha deve conter 4 números";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com a senha do cartão";
    }

    if (!GetUtils.isNumericOnly(_txt)) {
      return "Sua senha pode conter somente números";
    }

    if (RegExp(
            '^(0123|1234|2345|3456|4567|5678|6789|3210|4321|5432|6543|7654|8765|9876|0000|1111|2222|3333|4444|5555|6666|7777|8888|9999)\$')
        .hasMatch(_txt)) {
      return "Evite usar números sequenciais";
    }

    return null;
  }

  void activateVirtualCard() async {
    model.accountPassword = passwordController.value.text;
    loading.value = true;
    var response = await repository.activateVirtualCard(model);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshWallet');
      Get.toNamed(Routes.WALLET_ADD_CARD_IN_PROCCESS_STEP);
    }
  }

  void getCardPCIData() async {
    String password64 = SecurityUtils.encodeTo64(passwordController.value.text);
    loading.value = true;
    var response = await repository.getVirtualCardPCI(password64);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      pciModel.value = PCIVirtualCardModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      DartNotificationCenter.post(
          channel: 'refreshWallet', options: {'data': pciModel.value});
      // Get.offNamedUntil(Routes.MAIN_PAGES_HOLDER,
      //    (route) => route.settings.name == Routes.MAIN_PAGES_HOLDER);
      Get.back();
    }
  }
}
