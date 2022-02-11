import 'package:cGamer/app/data/repository/play_to_win_repositories/lol_repositories/lol_connection_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LolAccountValidationController extends GetxController {
  final LolRepository repository;

  LolAccountValidationController({required this.repository});

  var isLoading = false.obs;

  int? gameId;
  String? nick;

  @override
  void onInit() async {
    this.gameId = Get.arguments['gameId'];
    this.nick = Get.arguments['nick'];

    super.onInit();
  }

  Future connectAccount() async {
    try {
      this.isLoading.value = true;
      var response = await repository.connectAccount(gameId ?? 0, nick ?? "");
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      } else {
        Get.toNamed(Routes.LOL_SUCCESS);
      }
      this.isLoading.value = false;
    } catch (e) {
      this.isLoading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu.", title: "Atenção");
    }
  }
}
