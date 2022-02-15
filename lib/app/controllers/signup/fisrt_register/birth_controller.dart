import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/utils_export.dart';

class BirthController extends GetxController {
  var dateController = MaskedTextController(mask: "00/00/0000");
  var mothernameController = TextEditingController();
  var newTxtMask = MaskedTextController(mask: "00-00-0000");
  var formKey;
  UserRegisterModel _userModel = UserRegisterModel();

  @override
  void onReady() {
    _userModel = Get.arguments;
    super.onReady();
  }

  setBirthValue() => _userModel.birth = newTxtMask.value.text;

  void changePage() {
    Get.toNamed(Routes.SIGNUP_USERNAME, arguments: _userModel);
    //  Get.toNamed(Routes.SINGUP_EMAIL_STEP, arguments: _userModel);
  }

  dynamic validateDate(String _txt) {
    if (_txt.length == 10) {
      var validation = Validations().validateAge(16, _txt);
      if (validation == null) {
        convertMask(dateController.value);
        setBirthValue();
        return validation;
      }
      return validation;
    } else {
      return "Digite corretamente a sua data de nascimento.";
    }
  }

  dynamic validateMotherName(String _txt) {
    var validation = Validations().validateName(txt: _txt);
    if (validation != null) {
      return validation;
    }

    if (_txt.length < 3) {
      return "O nome da sua mãe está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com o nome da sua mãe";
    }

    // isNameValid.value = true;
    return null;
  }

  convertMask(TextEditingValue _value) => newTxtMask.value = _value;
}
