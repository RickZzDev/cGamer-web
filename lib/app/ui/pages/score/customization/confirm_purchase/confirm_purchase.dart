import 'package:cGamer/app/controllers/score/customization/confirm_purchase/confirm_purchase_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ConfirmPurchase extends StatelessWidget {
  final ConfirmPurchaseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: 'Customização',
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
                      Form(
                        key: controller.formKey,
                        child: CustomTextField(
                          controller: controller.password.value,
                          validation: (value) =>
                              controller.passwordIsValid(value: value),
                          labelText: 'Senha',
                          obscureText: true,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction:
                                    controller.confirmPurchase,
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
