import 'dart:convert';
import 'package:cGamer/app/data/models/score_models/buy_badges/my_badges_model.dart';
import 'package:cGamer/app/data/repository/score_repository/my_badge_repository/buy_badge_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class MyBadgeController extends GetxController {
  MyBadgeController({required this.repository});
  final MyBadgeRepository repository;

  Rx<Future?> hasCompletedBadgesRequest = Rx<Future?>(null);
  Rx<MyBadgesModel> badgesResult = MyBadgesModel().obs;
  final idBadgeSelected = 0.obs;
  final containsActive = false.obs;
  final loading = false.obs;

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
      badgesResult.value = MyBadgesModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      setContainsActive();
      return true;
    }
  }

  setContainsActive() {
    containsActive.value = false;
    if (badgesResult.value.badges != null) {
      badgesResult.value.badges?.forEach((element) {
        if (element.isActive ?? false) {
          containsActive.value = true;
        }
      });
    }
  }

  Future<bool> chooseBadge() async {
    loading.value = true;
    MyBadgeModelRequest modelRequest = MyBadgeModelRequest();
    modelRequest.id = idBadgeSelected.value;
    var response = await repository.chooseBadge(modelRequest);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshProfile');
      DartNotificationCenter.post(channel: 'refreshHome');
      SnackBarUtils.showSnackBar(
          desc: "Parabéns, você alterou seu badge com sucesso!",
          title: "Sucesso!",
          color: primaryColor);
      return true;
    }
  }

  void goNextPage() async {
    if (idBadgeSelected.value == 0) {
      if (containsActive.value) {
        badgesResult.value.badges?.forEach((element) {
          if (element.isActive ?? false) {
            idBadgeSelected.value = element.id!;
          }
        });
      } else {
        idBadgeSelected.value = -1;
      }
    }
    await chooseBadge();
  }
}
