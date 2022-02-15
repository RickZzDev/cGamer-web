import 'package:cGamer/app/data/models/score_models/buy_badges/buy_badge_model.dart';
import 'package:cGamer/app/data/repository/score_repository/buy_badge_repository/buy_badge_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class BuyBadgePasswordController extends GetxController {
  BuyBadgePasswordController({required this.repository});
  final BuyBadgeRepository repository;
  TextEditingController passwordController = TextEditingController();
  int? idBadgeSelected;
  final loading = false.obs;

  @override
  void onInit() {
    idBadgeSelected = Get.arguments['id_badge'];
    super.onInit();
  }

  Future<bool> buyBadge() async {
    loading.value = true;
    BuyBadgeModelRequest request = BuyBadgeModelRequest();
    request.id = idBadgeSelected;
    request.password = passwordController.value.text;
    var response = await repository.buyBadge(request);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              "Algo de errado ocorreu ao realizar sua compra, tente novamente mais tarde.",
          title: "Atenção");
      return false;
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshProfile');
      DartNotificationCenter.post(channel: 'refreshHome');
      DartNotificationCenter.post(channel: 'refreshScore');
      Get.toNamed(Routes.BUY_BADGES_SUCCESS);
      return true;
    }
  }

  void goNextPage() {
    if (!passwordController.value.text.isNotEmpty) {
      SnackBarUtils.showSnackBar(
          desc: "Preencha corretamente o campo com a senha", title: "Atenção");
    } else {
      buyBadge();
    }
  }
}
