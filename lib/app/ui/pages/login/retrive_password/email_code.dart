import 'package:cGamer/app/controllers/login/retrive_password/retrive_password_code_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EmailCodePage extends StatelessWidget {
  final RetrivePasswordCodeController _controller =
      Get.find<RetrivePasswordCodeController>();

  @override
  Widget build(BuildContext context) {
    _controller.buildContext = context;
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Recuperar senha",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  normalText: "Digite abaixo o código enviado para o",
                  customText: "seu e-mail",
                ),
                SizedBox(
                  height: 32,
                ),
                Form(
                  key: _controller.formKey,
                  child: CustomTextField(
                    labelText: "Código",
                    validation: _controller.validateField,
                    onChange: _controller.clearErrorAfterTexting,
                    controller: _controller.codeController,
                    validateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () =>
                              _controller.formKey.currentState?.validate() ??
                                      false
                                  ? _controller.validateCode()
                                  : null,
                          txtColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
