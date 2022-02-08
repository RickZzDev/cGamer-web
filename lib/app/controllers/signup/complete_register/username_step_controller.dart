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

class UsernameStepController extends GetxController {
  final UsernameRepository repository;
  UsernameStepController({required this.repository});
  CompleteRegisterPayload payload = CompleteRegisterPayload();
  TextEditingController usernameController = TextEditingController();
  dynamic response;
  var loading = false.obs;
  var serverError = false.obs;
  var formKey;
  changeServerErrorValue() => serverError.value = !serverError.value;
  UserRegisterModel _userModel = UserRegisterModel();

  @override
  void onReady() {
    _userModel = Get.arguments;
    super.onReady();
  }

  dynamic validateUsername(String txt) {
    if (txt.length < 3) {
      return "Nome de usuário precisa conter 3 caractéres ou mais";
    }

    if (!txt.isUsername()) {
      return "Caracteres especiais inválidos, somente permitidos . e _";
    }

    if (serverError.value) {
      return response.message.toString();
    }

    return null;
  }

  Future<void> verifyUsername() async {
    String username = usernameController.value.text;
    loading.value = true;
    response = await repository.verify(username);
    if (response is Exception) {
      loading.value = false;
      changeServerErrorValue();
      formKey.currentState?.validate();
    } else {
      loading.value = false;
      // payload = CompleteRegisterPayload.fromCepPages(
      //     cepmodel: CepModel(), number: "", complement: "", username: username);
      _userModel.username = username;
      //_key.currentState?.validate();
      // Get.toNamed(Routes.SINGUP_CEP_STEP, arguments: {"payload": payload});
    }
  }

  Future<void> changePage() async {
    await verifyUsername();
    if (_userModel.username != null) {
      Get.toNamed(Routes.SINGUP_EMAIL_STEP, arguments: _userModel);
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
