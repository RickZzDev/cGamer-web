import 'package:cGamer/app/data/repository/auth_register/auth_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/login_components/modal_bottom/modal_bottom_login.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var cpfController = MaskedTextController(mask: '000.000.000-00');
  var newCpfControllerMask = MaskedTextController(mask: '00000000000');
  final index = 0.obs;
  final logged = false.obs;
  final loginError = false.obs;

  dynamic authResponse;
  final authing = false.obs;
  BuildContext? buildContext;

  final AuthRepository repository;
  LoginController({required this.repository});

  clearCPFMask(TextEditingValue _value) => newCpfControllerMask.value = _value;
  setLoading() => authing.value = !authing.value;
  closeKeyoard(_context) => FocusScope.of(_context).requestFocus(FocusNode());
  void changeIndex(int _value) => this.index.value = _value;
  void goBackModal(int _value) =>
      this.index.value == 0 ? DoNothingAction() : this.index.value = _value;
  changeLoginErrorValue() => loginError.value = !loginError.value;

  void loginModalBottomSheet(context) async {
    LoginController _instanceLoginController = Get.find<LoginController>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        String _action;
        logged.value == true
            ? _action = "only_password"
            : _action = "login_password";
        return Obx(
          () => Container(
            height: Get.height * 0.65,
            child: ModalBottomSheetLogin(
              loginController: _instanceLoginController,
              action: _action,
              loading: authing.value,
            ),
          ),
        );
      },
    );
  }

  void verifyCpfToChangePage(dynamic _value) {
    if (_value.length == 14) {
      if (formKey.currentState?.validate() ?? false) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          changeIndex(1);
        });
      } else
        DoNothingAction();
    }
  }

  clearErrorAfterTexting(String value) {
    loginError.value ? loginError.value = false : DoNothingAction();
  }

  dynamic validatePassword(String _txt) {
    if (_txt.isEmpty) {
      return "Por favor, digite sua senha";
    }
    if (loginError.value) {
      return authResponse.message.toString();
    }
  }

  void goPrivacyPolices() async {
    GenericUtils.goPrivacyPolices(
        "https://joggabank.com.br/politica-de-privacidade/");
  }

  verifyIfIsException(dynamic responseHttp) async {
    if (ExceptionUtils.verifyIfIsException(responseHttp)) {
      changeLoginErrorValue();
      formKey.currentState?.validate();
    } else {
      CacheUtils.addToCache(
          key: 'x-token', value: responseHttp.headers['x-token']);
      Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
    }

    setLoading();
  }

  void auth() async {
    closeKeyoard(buildContext);
    setLoading();
    clearCPFMask(cpfController.value);
    authResponse = await repository.auth(
        newCpfControllerMask.value.text, passwordController.value.text);

    verifyIfIsException(authResponse);
  }
}
