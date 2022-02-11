import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessCompleteRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Dados completos",
          removeIcon: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cadastro completo! Agora só falta você validar seus documentos",
              style: textStyle.copyWith(),
            ),
            Container(
              height: 250,
              child:
                  Image.asset("assets/images/docs_images/docs_validating.png"),
            ),
            Container(
              child: GenericButton(
                text: "Voltar ao início",
                haveToReturnContext: false,
                onPressedFunction: () => Get.offNamed(Routes.MAIN_PAGES_HOLDER),
                txtColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
