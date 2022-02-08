import 'package:cGamer/app/controllers/login/retrive_password/retrive_password_email_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RetrivePasswordPage extends StatelessWidget {
  final RetrivePasswordEmailController _controller =
      Get.find<RetrivePasswordEmailController>();

  @override
  Widget build(BuildContext context) {
    _controller.buildContext = context;
    return Obx(
      () => ModalProgressHUD(
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
                      normalText: "Para recuperar sua senha, digite o",
                      customText: "e-mail cadastrado",
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _controller.formKey,
                      child: CustomTextField(
                          labelText: "E-mail",
                          validation: _controller.validateEmail,
                          onChange: _controller.clearErrorAfterTexting,
                          controller: _controller.emailController,
                          validateMode: AutovalidateMode.onUserInteraction,
                          type: TextInputType.emailAddress),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GenericButton(
                              text: "Avançar",
                              haveToReturnContext: false,
                              onPressedFunction: () =>
                                  _controller.formKey.currentState!.validate()
                                      ? _controller.sendCodeEmail()
                                      : null,
                              txtColor: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
