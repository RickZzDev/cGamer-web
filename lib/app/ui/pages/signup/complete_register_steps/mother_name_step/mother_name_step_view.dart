import 'package:cGamer/app/controllers/signup/complete_register/mother_name_step_controller.dart';
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

class MotherNameStepView extends StatefulWidget {
  @override
  _MotherNameStepView createState() => _MotherNameStepView();
}

class _MotherNameStepView extends State<MotherNameStepView> {
  final MotherNameStepController _controller =
      Get.find<MotherNameStepController>();

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
                appBarTxt: "Nome da mãe",
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
                        CustomRichText(
                          textAlign: TextAlign.start,
                          normalText: "Informe o ",
                          customText: "nome da sua mãe completo",
                          fontSize: 16,
                        ),
                      ],
                    ),
                    CustomRichText(
                      textAlign: TextAlign.start,
                      normalText: "e idêntico como consta em seu documento.",
                      customText: "",
                      fontSize: 16,
                    ),
                    Form(
                      key: _controller.formKey,
                      child: Container(
                        margin: EdgeInsets.only(top: 16, bottom: 8),
                        child: CustomTextField(
                          controller: _controller.motherNameController,
                          onChange: _controller.clearErrorAfterTexting,
                          validation: _controller.validateMotherName,
                          labelText: "Nome completo da mãe",
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
