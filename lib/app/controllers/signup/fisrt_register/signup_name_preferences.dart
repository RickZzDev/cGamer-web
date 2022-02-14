import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:regexpattern/regexpattern.dart';

class NamePreferrencesController extends GetxController {
  final docNameValue = 1.obs;
  final newNameValue = 2.obs;
  RxInt selectedValue = 0.obs;
  UserRegisterModel _userModel = UserRegisterModel();

  @override
  void onReady() {
    _userModel = Get.arguments;
    super.onReady();
  }

  var nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  dynamic validateName(String _txt) {
    var validation = Validations().validateName(txt: _txt);
    if (validation != null) {
      return validation;
    }

    if (_txt.length < 3) {
      return "Este nome está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com seu nome";
    }

    // isNameValid.value = true;
    return null;
  }

  dynamic validateNick(String _txt) {
    if (_txt.length < 3) {
      return "Este nome está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com seu nome";
    }

    if (!RegVal.hasMatch(_txt, "^[ a-zA-Z\u00C0-\u00FF]*\$")) {
      return "Caracteres especiais e números não são permitidos no seu nome";
    }

    return null;
  }

  bool validateAllForm() {
    if (selectedValue.value == 1) {
      return true;
    } else if (selectedValue.value == 2 &&
        (formKey.currentState?.validate() ?? false)) {
      return true;
    } else if (selectedValue.value == 0) {
      SnackBarUtils.showSnackBar(
          title: "Atenção", desc: "Por favor, escolha uma das opções.");
      return false;
    } else {
      return false;
    }
  }

  void setSelecteValue(int value) => selectedValue.value = value;

  void setUserNick() => _userModel.nick =
      selectedValue.value == 1 ? _userModel.name : nameController.value.text;

  void changePage() {
    setUserNick();

    Get.toNamed(Routes.SINGUP_BIRTH_MNAME_STEP, arguments: _userModel);
  }
}
