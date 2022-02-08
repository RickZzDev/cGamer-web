import 'package:cGamer/app/data/repository/score_repository/customization_repository/confirm_purchase_repositoy/confirm_purchase_repository.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ConfirmPurchaseController extends GetxController {
  ConfirmPurchaseController({required this.repository});
  final ConfirmPurchaseRepository repository;

  Rx<TextEditingController> password = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? nickColor;
  final loading = false.obs;

  @override
  void onInit() {
    var arguments = Get.arguments["nick_color"];
    nickColor = arguments;
    super.onInit();
  }

  Future confirmPurchase() async {
    if (password.value.text.isEmpty) {
      SnackBarUtils.showSnackBar(
          desc: "Informe a senha da sua conta para efetuar a compra.",
          title: "Atenção");
    } else {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      try {
        loading.value = true;
        var response = await repository.confirmPurchase(
            color: nickColor!, password: password.value.text);
        if (ExceptionUtils.verifyIfIsException(response)) {
          loading.value = false;
          SnackBarUtils.showSnackBar(
              desc:
                  "Ocorreu um erro ao tentar finalizar a compra, tente novamente mais tarde!",
              title: "Atenção");
        } else {
          loading.value = false;
          DartNotificationCenter.post(channel: 'refreshHome');
          DartNotificationCenter.post(channel: 'refreshProfile');
          DartNotificationCenter.post(channel: 'refreshScore');
          Get.offAllNamed(Routes.CUSTOMIZATION_CONFIRM_PURCHASE_SUCESS);
        }
      } catch (e) {
        if (loading.value == true) {
          loading.value = false;
        }
        SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao tentar finalizar a compra, tente novamente mais tarde!",
          title: "Atenção",
        );
      }
    }
  }

  dynamic passwordIsValid({String? value}) {
    if (value?.isEmpty ?? true) {
      return "Sua senha não pode estar em branco.";
    }
    return null;
  }
}
