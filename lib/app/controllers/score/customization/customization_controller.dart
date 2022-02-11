import 'package:cGamer/app/data/models/score_models/customization/color_customization_model.dart';
import 'package:cGamer/app/data/repository/score_repository/customization_repository/customization_repository.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class CustomizationController extends GetxController {
  CustomizationController({required this.repository});
  final CustomizationRepository repository;
  Rx<Color>? nickColor;
  String? colorSelected;
  final loading = false.obs;
  Rx<ColorCustomizationModel> model = ColorCustomizationModel().obs;
  final hasCompletedColorRequest = false.obs;

  @override
  void onInit() {
    nickColor = Color(0xffFFFFFF).obs;
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedColorRequest.value = await getColors();
    super.onReady();
  }

  changeNickColor(String color) {
    colorSelected = color;
    nickColor?.value = GenericUtils.getColorWithHex(color);
  }

  Future<bool> getColors() async {
    loading.value = true;

    var response = await repository.getColors();

    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: 'Ocorreu um erro inesperado, tente novamente.',
          title: 'Atenção');
      return false;
    } else {
      loading.value = false;
      var jsonData = json.decode(response.body);
      model.value = ColorCustomizationModel.fromJson(jsonData);
      return true;
    }
  }

  void isValidToContinue() {
    double priceColor = model.value.priceColor ?? 0.0;
    double balance = model.value.customerBalancePoints ?? 0.0;
    if (model.value.customerUsername == null) {
      SnackBarUtils.showSnackBar(
          desc:
              'Complete os dados e crie um nome de usuário para poder comprar a cor.',
          title: 'Atenção');
      return;
    } else if (colorSelected == null) {
      SnackBarUtils.showSnackBar(
          desc: 'Você precisa selecionar uma cor.', title: 'Atenção');
      return;
    } else if (priceColor > balance) {
      SnackBarUtils.showSnackBar(
          desc: 'Saldo insuficiente :(', title: 'Atenção');
      return;
    } else {
      Get.toNamed(Routes.CUSTOMIZATION_CONFIRM_PURCHASE,
          arguments: {"nick_color": colorSelected});
    }
  }
}
