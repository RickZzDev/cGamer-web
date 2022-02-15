import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VirtualCardBlockAccountPassowordController extends GetxController {
  final CardRepository repository;
  VirtualCardBlockAccountPassowordController({required this.repository});

  TextEditingController passwordController = TextEditingController();
  String action = "";
  final formKey = GlobalKey<FormState>();
  VirtualCardPasswordsRequestModel model = VirtualCardPasswordsRequestModel();
  final loading = false.obs;

  @override
  void onInit() {
    action = Get.arguments != null ? Get.arguments["action"] : "";
    model = Get.arguments['model_request'];
    super.onInit();
  }

  dynamic validatePassword(String _txt) {
    if (_txt.isEmpty) {
      return "Favor preencher com a senha da sua conta";
    }

    return null;
  }

  void blockVirtualCard() async {
    model.accountPassword = passwordController.value.text;
    loading.value = true;
    var response = await repository.blockVirtualCard(model);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc:
              "Ocorreu um erro ao tentar bloquear seu cartão, tente novamente mais tarde.");

      // SnackBarUtils.showSnackBar(
      //     title: "Atenção",
      //     desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshWallet');
      Get.toNamed(Routes.WALLET_BLOCK_VIRTUAL_CARD_SUCCESS_STEP,
          arguments: {'action': action});
    }
  }

  void unblockVirtualCard() async {
    model.accountPassword = passwordController.value.text;
    loading.value = true;
    var response = await repository.unblockVirtualCard(model);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshWallet');
      Get.toNamed(Routes.WALLET_BLOCK_VIRTUAL_CARD_SUCCESS_STEP,
          arguments: {'action': action});
    }
  }

  void deleteVirtualCard() async {
    model.accountPassword = passwordController.value.text;
    loading.value = true;
    var response = await repository.deleteVirtualCard(model);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: response.toString().replaceAll("Exception: ", ""));
    } else {
      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshWallet');
      Get.toNamed(Routes.WALLET_BLOCK_VIRTUAL_CARD_SUCCESS_STEP,
          arguments: {'action': action});
    }
  }
}
