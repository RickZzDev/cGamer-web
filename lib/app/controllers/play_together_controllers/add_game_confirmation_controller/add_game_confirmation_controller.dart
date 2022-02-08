import 'dart:async';

import 'package:cGamer/app/data/models/play_together_models/add_game_confirmations_model.dart';
import 'package:cGamer/app/data/models/play_together_models/add_game_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/add_new_game_repositories/add_new_game_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGameConfirmationController extends GetxController {
  final AddNewGameRepository repository;

  AddGameConfirmationModel model = Get.arguments;
  late Rx<List<AddGamePlatform>?> reactiveList;
  TextEditingController userNameController = TextEditingController();
  AddGameConfirmationController(this.repository);

  /*   */
  var isPostingANewGame = false.obs;
  bool get isLoading => isPostingANewGame.value;
  /*  */

  bool validNickName = false;

  bool get hasPlatformSelected => getSelectedPlatforms().length > 0;

  bool get validButton => hasPlatformSelected && validNickName;

  @override
  void onInit() {
    reactiveList = model.addGameModel.platforms.obs;
  }

  nickValidation(String value) {
    if (value.length < 3) {
      validNickName = false;
      return "Insira um nick válido";
    }
    validNickName = true;
    return null;
  }

  postNewGame() async {
    if (!validButton) {
      SnackBarUtils.showSnackBar(
          desc: "Preencha o nick e escolha uma plataforma.", title: "Atenção");
      return;
    }

    AddGamePostModel postModel = new AddGamePostModel(
        id: model.addGameModel.id ?? 0,
        platforms: getSelectedPlatforms(),
        nickName: userNameController.text);

    try {
      isPostingANewGame.value = true;

      var response = await repository.postNewGame(postModel);

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, atualize a página.",
            title: "Atenção");

        isPostingANewGame.value = false;
        return;
      }
      DartNotificationCenter.post(channel: "refreshPlayTogether");
      SnackBarUtils.showSnackBar(
          color: primaryColor,
          desc: "Seu jogo foi adicionado.",
          title: "Sucesso");

      Timer(Duration(seconds: 1), () => {Get.back(), Get.back(), Get.back()});

      return;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      isPostingANewGame.value = false;
    }
  }

  List<int> getSelectedPlatforms() {
    List<int> selectedPlatforms = [];

    reactiveList.value!.forEach((element) {
      if (element.isSelected) {
        selectedPlatforms.add(element.id ?? 0);
      }
    });
    return selectedPlatforms;
  }
}

class AddGamePostModel {
  final int id;
  final List<int> platforms;
  final String nickName;

  AddGamePostModel(
      {required this.id, required this.platforms, required this.nickName});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "platforms": this.platforms,
      "nickname": this.nickName
    };
  }
}
