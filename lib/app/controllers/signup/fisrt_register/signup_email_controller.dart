import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/utils/utils_export.dart';

class SignUpEmailStepController extends GetxController {
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  final switchValue = false.obs;
  final checkBoxValue = false.obs;
  final isEmailValid = false.obs;

  UserRegisterModel _userModel = UserRegisterModel();

  @override
  void onReady() {
    _userModel = Get.arguments;
    super.onReady();
  }

  void setCheckBox(value) => this.checkBoxValue.value = value;

  void setEmail() => _userModel.email = emailController.value.text;
  void setCode() => _userModel.indicationCode = codeController.value.text;

  void changePage() => Get.toNamed(Routes.SINGUP_PASSWORD_STEP,
      arguments: {"retrive_password": false, "user_model": _userModel});

  dynamic validateEmail(String _txt) {
    var result = Validations().validateEmail(_txt);
    result != null ? isEmailValid.value = false : isEmailValid.value = true;
    return result;
  }

  dynamic validateCode(String _txt) {
    if (_txt.length >= 6) {
      return null;
    }
    return "O código de indicação precisa conter 6 digitos.";
  }

  bool validateAllForm(GlobalKey<FormState> formKey) {
    if ((formKey.currentState?.validate() ?? false) && checkBoxValue.value) {
      setEmail();
      setCode();
      return true;
    } else {
      return false;
    }
  }

  void onChangedSwitch(bool value) async {
    if (switchValue.value == true) {
      switchValue.value = value;
      codeController.text = "";
    } else {
      switchValue.value = value;
    }
  }
}
