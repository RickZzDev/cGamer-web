import 'package:cGamer/app/data/models/profile_model/change_password_model/change_password_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OldPasswordController extends GetxController {
  var oldPasswordController = TextEditingController();

  final isOldPasswordValid = false.obs;

  final _changePasswordModel = ChangePasswordModel();

  dynamic validateOldPassword(String _txt) {
    _changePasswordModel.password = oldPasswordController.value.text;

    if (_txt.isEmpty) {
      isOldPasswordValid.value = false;
      return "Favor preencher o campo com sua senha atual";
    }
    if (_txt.length < 8) {
      isOldPasswordValid.value = false;
      return "Sua senha precisa de ter no mínimo 8 caractéres";
    }

    isOldPasswordValid.value = true;
    return null;
  }

  void setOldPassword() =>
      _changePasswordModel.password = oldPasswordController.value.text;

  bool validateAllForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      setOldPassword();
      return true;
    } else {
      return false;
    }
  }

  void changePage() => Get.toNamed(Routes.SINGUP_PASSWORD_STEP, arguments: {
        "retrive_password": false,
        "change_password": true,
        "change_password_model": _changePasswordModel
      });
}
