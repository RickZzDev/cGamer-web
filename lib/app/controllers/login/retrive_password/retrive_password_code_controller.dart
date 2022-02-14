import 'package:cGamer/app/data/models/retrive_password_models/retrive_password_model.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_code_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class RetrivePasswordCodeController extends GetxController {
  RetrivePasswordModel _retrivePasswordModel = RetrivePasswordModel();

  final formKey = GlobalKey<FormState>();
  var codeController = TextEditingController();
  final loading = false.obs;
  final serverError = false.obs;

  BuildContext? buildContext;
  dynamic response;

  setLoading() => loading.value = !loading.value;
  closeKeyboard(_context) => FocusScope.of(_context).requestFocus(FocusNode());
  changeServerErrorValue() => serverError.value = !serverError.value;

  final RetrivePasswordCodeRepository repository;
  RetrivePasswordCodeController({required this.repository});

  @override
  void onReady() {
    _retrivePasswordModel = Get.arguments;
    super.onReady();
  }

  void validateCode() async {
    closeKeyboard(buildContext);
    setLoading();

    response = await repository.validateCode(
        _retrivePasswordModel.email ?? "", codeController.value.text);
    verifyIfIsException(response, buildContext!);
  }

  verifyIfIsException(dynamic responseHttp, BuildContext _context) async {
    setLoading();
    if (!ExceptionUtils.verifyIfIsException(responseHttp) &&
        responseHttp != null) {
      _retrivePasswordModel.code = codeController.value.text;
      Get.toNamed(Routes.SINGUP_PASSWORD_STEP, arguments: {
        "retrive_password": true,
        "retrive_password_model": _retrivePasswordModel
      });
    } else {
      changeServerErrorValue();
      formKey.currentState?.validate();
    }
  }

  clearErrorAfterTexting(String value) {
    serverError.value ? serverError.value = false : DoNothingAction();
  }

  dynamic validateField(String _txt) {
    if (_txt.isNotEmpty && _txt.length < 8) {
      return "Preencha corretamente o código";
    }
    if (serverError.value) {
      return response.message.toString();
    }
  }
}
