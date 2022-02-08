import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessValidateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            appBarTxt: "Validação de documentos",
            removeIcon: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 32,
              bottom: 32,
              left: 32,
              right: 32,
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRichText(
                    textAlign: TextAlign.center,
                    normalText: "Agora é só",
                    customText: "aguardar",
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Container(
                    width: screenWidthhSize * 0.6,
                    child: Image.asset(
                        "assets/images/docs_images/docs_validating.png"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Estamos analisando a sua documentação em breve você será notificado com o resultado da análise",
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GenericButton(
                            text: "Ir para o início",
                            haveToReturnContext: false,
                            onPressedFunction: () {
                              DartNotificationCenter.post(
                                  channel: 'refreshHome');
                              Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
                            },
                            txtColor: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
