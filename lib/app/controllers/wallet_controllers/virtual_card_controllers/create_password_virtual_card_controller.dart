import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CreateVirtualCardPassowordController extends GetxController {
  final CardRepository repository;
  CreateVirtualCardPassowordController({required this.repository});

  TextEditingController newPasswordController = TextEditingController();
  String? accPassword;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final loading = false.obs;

  @override
  void onInit() {
    accPassword = Get.arguments['accountPassword'];
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

  void goNextPage() async {
    loading.value = true;
    String newPassword64 =
        SecurityUtils.encodeTo64(newPasswordController.value.text);
    var response = await repository.changePasswordVirtualCard(
        accPassword ?? "", newPassword64);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      Get.toNamed(Routes.WALLET_SETTINGS_PASSWORD_CHANGE_SUCCESS);
    }
  }
}
