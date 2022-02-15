import 'package:cGamer/app/controllers/score/payment/payment_score_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PaymentScorePassword extends StatelessWidget {
  final _controller = Get.find<PaymentScoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: 'Finalizar troca',
            ),
            preferredSize: Size.fromHeight(70)),
        body: Obx(() => ModalProgressHUD(
              inAsyncCall: _controller.isLoading.value,
              child: Container(
                height: screenHeigthSize,
                width: screenWidthhSize,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomRichText(
                        textAlign: TextAlign.left,
                        normalText: 'Informe abaixo a',
                        customText: 'senha da sua conta',
                        normalText2: 'para confirmar sua troca:',
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        controller: _controller.passwordController,
                        validation: Validations().passwordBigger,
                        labelText: 'Senha',
                        autoFocus: false,
                        obscureText: true,
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GenericButton(
                                text: "Trocar",
                                haveToReturnContext: false,
                                onPressedFunction: _controller.onTap,
                                txtColor: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
