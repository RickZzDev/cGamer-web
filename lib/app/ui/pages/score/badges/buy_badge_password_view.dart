import 'package:cGamer/app/controllers/score/buy_badge/buy_badge_password_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class BuyBadgePasswordView extends StatelessWidget {
  BuyBadgePasswordController controller =
      Get.find<BuyBadgePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: 'Confirmar compra',
            ),
            preferredSize: Size.fromHeight(70)),
        body: Obx(() => ModalProgressHUD(
              inAsyncCall: controller.loading.value,
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
                        normalText: 'Muito bom! Agora informe a',
                        normalText2: 'para',
                        customText: 'senha da sua conta',
                        customText2: 'confirmarmos a compra!',
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        labelText: 'Senha',
                        obscureText: true,
                        controller: controller.passwordController,
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () {
                                  controller.goNextPage();
                                },
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
