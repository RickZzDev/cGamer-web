import 'package:cGamer/app/data/models/retrive_password_models/retrive_password_model.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_email_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/validation_utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetrivePasswordEmailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  final loading = false.obs;
  final serverError = false.obs;

  final _retrivePasswordModel = RetrivePasswordModel();

  BuildContext? buildContext;
  dynamic response;

  setLoading() => loading.value = !loading.value;
  closeKeyboard(_context) => FocusScope.of(_context).requestFocus(FocusNode());
  changeServerErrorValue() => serverError.value = !serverError.value;

  final RetrivePasswordEmailRepository repository;
  RetrivePasswordEmailController({required this.repository});

  void sendCodeEmail() async {
    closeKeyboard(buildContext);
    setLoading();

    response = await repository.sendCodeForEmail(emailController.value.text);
    verifyIfIsException(response, buildContext!);
  }

  verifyIfIsException(dynamic responseHttp, BuildContext _context) async {
    if (!ExceptionUtils.verifyIfIsException(responseHttp) &&
        responseHttp != null) {
      _retrivePasswordModel.email = emailController.value.text;
      Get.toNamed(Routes.RETRIVE_PASSWORD_EMAIL_CODE,
          arguments: _retrivePasswordModel);
    } else {
      changeServerErrorValue();
      formKey.currentState?.validate();
    }
    setLoading();
  }

  clearErrorAfterTexting(String value) {
    serverError.value ? serverError.value = false : DoNothingAction();
  }

  dynamic validateEmail(String _txt) {
    var validateEmail = Validations().validateEmail(_txt);
    if (validateEmail != null) {
      return validateEmail;
    }
    if (serverError.value) {
      return response.message.toString();
    }
  }
}
