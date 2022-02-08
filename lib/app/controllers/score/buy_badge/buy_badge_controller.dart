import 'dart:convert';

import 'package:cGamer/app/data/models/score_models/buy_badges/buy_badge_model.dart';
import 'package:cGamer/app/data/repository/score_repository/buy_badge_repository/buy_badge_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class BuyBadgeController extends GetxController {
  BuyBadgeController({required this.repository});
  final BuyBadgeRepository repository;
  Rx<Future?> hasCompletedBadgesRequest = Rx<Future?>(null);
  Rx<BuyBadgeModel> badgesResult = BuyBadgeModel().obs;
  final idBadgeSelected = 0.obs;
  final loading = false.obs;
  var gCoins;

  @override
  void onInit() {
    gCoins = Get.arguments['gCoins'];
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedBadgesRequest.value = getBadges();
    super.onReady();
  }

  void setBadgeSelected(int id) {
    idBadgeSelected.value = id;
  }

  Future<bool> getBadges() async {
    loading.value = true;
    var response = await repository.getBadges();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      badgesResult.value = BuyBadgeModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  void goNextPage() {
    double sellPoints =
        badgesResult.value.badges?[idBadgeSelected.value - 1].sellPoints ?? 0.0;
    if (idBadgeSelected.value == 0) {
      SnackBarUtils.showSnackBar(
          desc: "Selecione um badge para continuar.", title: "Atenção");
    } else if (double.parse(gCoins) < sellPoints) {
      SnackBarUtils.showSnackBar(
          desc: "Você não possui saldo suficiente :(", title: "Atenção");
    } else {
      Get.toNamed(Routes.BUY_BADGES_CONFIRM,
          arguments: {'id_badge': idBadgeSelected.value});
    }
  }
}
