import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VirtualCardBlockPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  String action = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  VirtualCardPasswordsRequestModel model = VirtualCardPasswordsRequestModel();
  final loading = false.obs;

  @override
  void onInit() {
    action = Get.arguments != null ? Get.arguments["action"] : "";
    super.onInit();
  }

  dynamic validatePassword(String _txt) {
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

  void goNextPage() {
    model.password = passwordController.value.text;
    Get.toNamed(Routes.WALLET_BLOCK_VIRTUAL_CARD_ACCOUNT_PASSWORD_STEP,
        arguments: {'action': action, 'model_request': model});
  }
}
