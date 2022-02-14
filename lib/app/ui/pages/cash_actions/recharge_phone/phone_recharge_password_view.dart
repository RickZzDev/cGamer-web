import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_password_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/utils/validation_utils/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneRechargePasswordView extends StatelessWidget {
  final PhoneRechargePasswordController _controller =
      Get.find<PhoneRechargePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.inAssyncCall.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: utils.primaryColor,
        ),
        child: Scaffold(
          backgroundColor: utils.secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Confirmação",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    normalText: "Muito bom! Agora",
                    textAlign: TextAlign.start,
                    customText: "informe sua senha para confirmarmos a recarga",

                    // customFirst: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: _controller.passwordController,
                    labelText: "Senha",
                    obscureText: true,
                    validation: Validations().passwordBigger,
                    validateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Expanded(
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GenericButton(
                          text: "Avançar",
                          onPressedFunction: () =>
                              _controller.formKey.currentState?.validate() ??
                                      false
                                  ? _controller.changePage()
                                  : null,
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
    );
  }
}
