import 'package:cGamer/app/controllers/signup/complete_register/phone_code_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneCodeStepView extends StatefulWidget {
  @override
  _PhoneCodeStepView createState() => _PhoneCodeStepView();
}

class _PhoneCodeStepView extends State<PhoneCodeStepView> {
  final PhoneCodeController _controller = Get.find<PhoneCodeController>();

  @override
  void initState() {
    _controller.payload = Get.arguments["payload"];
    _controller.phoneWithMask.text = _controller.payload.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
          inAsyncCall: _controller.validatingCode.value,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: CustomAppBar(
                  appBarTxt: "Confirmação",
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textStyle.copyWith(),
                        children: <TextSpan>[
                          TextSpan(text: "Digite o "),
                          TextSpan(
                            text: "código ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "que foi enviado "),
                          TextSpan(
                            text:
                                "para o número ${_controller.phoneWithMask.text}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _controller.formCodeKey,
                      child: Container(
                        margin: EdgeInsets.only(top: 16, bottom: 8),
                        child: CustomTextField(
                          controller: _controller.codeController,
                          type: TextInputType.number,
                          labelText: "Digite o código",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  _controller.verifyTimeToSendSmsFromCodeView(),
                              child: Text(
                                "Reenviar o código",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () => _controller
                                        .validateCodeField()
                                    ? _controller.completeRegister()
                                    : SnackBarUtils.showSnackBar(
                                        title: "Atenção",
                                        desc:
                                            "Por favor digite o código que recebeu via sms. Caso não tenha recebido, clique em reenviar código"),
                                txtColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
