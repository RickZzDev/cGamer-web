import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BuyBadgeSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            width: screenWidthhSize,
            height: screenHeigthSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Parabéns!\n Você acaba de aumentar sua coleção de badges.',
                  textAlign: TextAlign.center,
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 26),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Vá até seu Perfil em Meus Badges e ative o seu preferido!",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset(
                  "assets/images/BG_Sucesso.svg",
                  height: 400,
                ),
                GenericButton(
                    color: secondaryColor,
                    text: 'Voltar ao Ínicio',
                    txtColor: Colors.white,
                    onPressedFunction: () {
                      Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
