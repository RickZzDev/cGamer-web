import 'package:cGamer/app/controllers/marketplace/marketplace_password_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MarketPlacePasswordView extends StatelessWidget {
  final MarketPlacePasswordController _controller =
      Get.find<MarketPlacePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            appBarTxt: "Pagamento",
          ),
        ),
        body: Obx(
          () => ModalProgressHUD(
            inAsyncCall: _controller.loading.value,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ), // color: ,
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    normalText: "Muito bom! Agora",
                    customText: "informe sua senha",
                    normalText2: "para",
                    customText2: "confirmarmos o pagamento ",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    labelText: "Senha",
                    obscureText: true,
                    controller: _controller.passwordController,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GenericButton(
                          text: "Finalizar",
                          onPressedFunction: () => _controller.purchase(),
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
