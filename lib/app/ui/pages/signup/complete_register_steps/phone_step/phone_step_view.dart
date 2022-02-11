import 'package:cGamer/app/controllers/signup/complete_register/phone_step_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneStepView extends StatefulWidget {
  @override
  _PhoneStepView createState() => _PhoneStepView();
}

class _PhoneStepView extends State<PhoneStepView> {
  final PhoneStepController _controller = Get.find<PhoneStepController>();

  @override
  void initState() {
    _controller.payload = Get.arguments["payload"];
    super.initState();
  }

  @override
  void dispose() {
    _controller.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.sendingCode.value,
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
              appBarTxt: "Confirmação",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 30),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.start,
                        normalText: "E para finalizar, digite",
                        customText: "o número do celular com DDD"),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 8),
                      child: CustomTextField(
                        controller: _controller.phoneController,
                        type: TextInputType.number,
                        labelText: "Número do celular",
                      ),
                    ),
                    Text(
                      "Em alguns segundos, você vai receber um código para a validação do seu número",
                      style: textStyle.copyWith(fontSize: 14),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GenericButton(
                            text: "Receber código",
                            haveToReturnContext: false,
                            onPressedFunction: () => _controller
                                    .validatePhoneField()
                                ? _controller.verifyCodeTochangePage()
                                : SnackBarUtils.showSnackBar(
                                    title: "Atenção",
                                    desc:
                                        "Preencha com todos os números do seu telefone"),
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
