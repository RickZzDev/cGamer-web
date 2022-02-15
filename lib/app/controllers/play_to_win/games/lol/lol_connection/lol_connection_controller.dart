import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LolConnectionController extends GetxController {
  int? _gameId;
  TextEditingController nickText = TextEditingController();
  var formState = GlobalKey<FormState>();
  @override
  void onInit() {
    this._gameId = Get.arguments['id'];
    super.onInit();
  }

  void toAccountValidationPage() {
    if (this.formState.currentState?.validate() ?? false) {
      Get.toNamed(Routes.LOL_VALIDATION,
          arguments: {"nick": nickText.text, "gameId": this._gameId});
      return;
    }
    SnackBarUtils.showSnackBar(
        desc: "Nome de invocador inválido.", title: "Atenção");
  }

  dynamic nickIsValid(String txt) {
    if (nickText.text.isEmpty) {
      return "Não deixe o campo em branco.";
    }
    return null;
  }
}
