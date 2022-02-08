import 'package:cGamer/app/controllers/signup/complete_register/username_step_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UsernameStepView extends StatefulWidget {
  @override
  _UsernameStepView createState() => _UsernameStepView();
}

class _UsernameStepView extends State<UsernameStepView> {
  final UsernameStepController _controller = Get.find<UsernameStepController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.formKey = formKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        color: Colors.black,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).accentColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(
                appBarTxt: "Nome de usuário",
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 30),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Escolha um @ ",
                            textAlign: TextAlign.start,
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold)),
                        CustomRichText(
                            textAlign: TextAlign.start,
                            normalText: "para pagar, receber e",
                            customText: ""),
                      ],
                    ),
                    CustomRichText(
                      textAlign: TextAlign.start,
                      normalText: "também ser encontrado por seus amigos",
                      customText: "",
                    ),
                    Form(
                      key: _controller.formKey,
                      child: Container(
                        margin: EdgeInsets.only(top: 16, bottom: 8),
                        child: CustomTextField(
                          controller: _controller.usernameController,
                          onChange: _controller.clearErrorAfterTexting,
                          validation: _controller.validateUsername,
                          labelText: "Escolha um @",
                          autoFocus: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GenericButton(
                            text: "Avançar",
                            haveToReturnContext: false,
                            onPressedFunction: () async {
                              if (_controller.formKey.currentState
                                      ?.validate() ??
                                  false) {
                                await _controller.changePage();
                              }
                            },
                            txtColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
