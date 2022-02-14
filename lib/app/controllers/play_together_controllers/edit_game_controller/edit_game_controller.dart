import 'dart:async';

import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/play_together_repository.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditGameController extends GetxController {
  final PlayTogetherRepository repository;
  EditGameController(this.repository);
  EditGameModel editGameModel = Get.arguments;

  TextEditingController nickController = TextEditingController();

  /*   */
  var isSaveLoading = false.obs;
  var isExclusionLoading = false.obs;
  /*   */

  bool isValidForm = true;

  bool get isLoading => isSaveLoading.value || isExclusionLoading.value;

  @override
  void onInit() {
    nickController.text = editGameModel.game.nickName ?? "";
    super.onInit();
  }

  Future editAGame() async {
    isSaveLoading.value = true;

    try {
      var response = await repository.editAGame(
          platformId: editGameModel.platformId.toString(),
          gameId: editGameModel.game.id.toString(),
          nickName: nickController.text);

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        isSaveLoading.value = false;
        return;
      }
      SnackBarUtils.showSnackBar(
          desc: "Seu nome de usuário foi alterado com sucesso",
          title: "Sucesso",
          color: primaryColor);
      editGameModel.game.nickName = nickController.text;
      isSaveLoading.value = false;

      DartNotificationCenter.post(channel: "refreshPlayTogether");
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      isSaveLoading.value = false;
    }
  }

  Future removeAGame() async {
    isExclusionLoading.value = true;

    try {
      var response = await repository.removeAGame(
          platformId: editGameModel.platformId.toString(),
          gameId: editGameModel.game.id.toString());

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        isExclusionLoading.value = false;
        return;
      }

      DartNotificationCenter.post(channel: "refreshPlayTogether");
      isExclusionLoading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Seu Jogo foi excluido com sucesso.",
          title: "Sucesso",
          color: primaryColor);

      Timer(Duration(seconds: 1), () => {Get.back()});
      isExclusionLoading.value = false;
      return;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      isExclusionLoading.value = false;
      return;
    }
  }

  dynamic nickVerification(String value) {
    if (value.length < 3) {
      isValidForm = false;
      return "Digite um nick válido";
    }
    isValidForm = true;

    return null;
  }
}

class EditGameModel {
  final PlayTogetherGame game;
  final int platformId;

  EditGameModel({required this.game, required this.platformId});
}
