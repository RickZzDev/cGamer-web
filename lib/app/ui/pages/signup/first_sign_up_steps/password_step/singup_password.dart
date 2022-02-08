import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/controllers/signup/fisrt_register/password_controller.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';

class PasswordStep extends StatefulWidget {
  @override
  _PasswordStepState createState() => _PasswordStepState();
}

class _PasswordStepState extends State<PasswordStep> {
  bool isRegisterFlow = true;
  bool isChangePasswordFlow = false;

  @override
  void initState() {
    super.initState();
    isChangePasswordFlow =
        Get.arguments != null && Get.arguments["change_password"] == true
            ? true
            : false;

    isRegisterFlow = Get.arguments == null ||
            (Get.arguments["retrive_password"] == false &&
                !isChangePasswordFlow)
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    PasswordController _controller = Get.find<PasswordController>();

    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.registeringUser.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ), // color: ,
        color: Colors.black,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: isRegisterFlow ? "Segurança" : "Alterar Senha",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isRegisterFlow
                    ? RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontFamily: 'Exo'),
                          children: <TextSpan>[
                            TextSpan(text: 'Muito bom! Agora informe'),
                            TextSpan(
                              text: '  uma senha de acesso',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' para protegermos sua conta'),
                          ],
                        ),
                      )
                    : CustomRichText(
                        normalText: "Informe",
                        customText: "sua nova senha",
                      ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  labelText: "Senha",
                  onChange: _controller.changePasswordFiled,
                  controller: _controller.passwordControllerTxt,
                  obscureText: true,
                  autoFocus: false,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Algumas regrinhas para a sua senha:",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Obx(
                  () => ValidationIndication(
                    txt: "• Mínimo 8 caracteres",
                    valid: _controller.eightCharacteres.value,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Obx(() => ValidationIndication(
                      txt: "• Letra minúscula",
                      valid: _controller.lowerCaseLetter.value,
                    )),
                SizedBox(
                  height: 8,
                ),
                Obx(() => ValidationIndication(
                      txt: "• Letra maiúscula ",
                      valid: _controller.upperCaseLetter.value,
                    )),
                SizedBox(
                  height: 8,
                ),
                Obx(
                  () => ValidationIndication(
                    txt: "• Pelo menos um número",
                    valid: _controller.oneNumber.value,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Obx(
                        () => GenericButton(
                          text: isChangePasswordFlow
                              ? "Alterar senha"
                              : "Finalizar",
                          haveToReturnContext: true,
                          onPressedFunction: _controller.validateAllCases()
                              ? isRegisterFlow
                                  ? _controller.registerUser
                                  : isChangePasswordFlow
                                      ? _controller.changeUserPassword
                                      : _controller.retriveUserPassword
                              : null,
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
