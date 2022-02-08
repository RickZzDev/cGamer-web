import 'package:cGamer/app/data/models/complete_register/adress_models/cep_model.dart';
import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/username_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

class MotherNameStepController extends GetxController {
  CompleteRegisterPayload payload = CompleteRegisterPayload();
  TextEditingController motherNameController = TextEditingController();
  dynamic response;
  var loading = false.obs;
  var serverError = false.obs;
  var formKey;
  changeServerErrorValue() => serverError.value = !serverError.value;

  @override
  void onReady() {
    super.onReady();
  }

  dynamic validateMotherName(String txt) {
    if (txt.length < 3) {
      return "Nome da mãe precisa ser completo e idêntico ao documento";
    }

    if (serverError.value) {
      return response.message.toString();
    }

    return null;
  }

  Future<void> changePage() async {
    if (motherNameController.text != "") {
      payload = CompleteRegisterPayload.fromCepPages(
          cepmodel: CepModel(),
          number: "",
          complement: "",
          motherName: motherNameController.text);
      Get.toNamed(Routes.SINGUP_CEP_STEP, arguments: {"payload": payload});
    } else {
      SnackBarUtils.showSnackBar(
          desc: "Preencha corretamente seu nome de usuário", title: "Atenção");
    }

    //  Get.toNamed(Routes.SINGUP_EMAIL_STEP, arguments: _userModel);
  }

  clearErrorAfterTexting(String value) {
    serverError.value ? serverError.value = false : DoNothingAction();
  }
}
