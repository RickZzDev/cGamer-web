import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsPasswordChangeSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Text(
              "Senha alterada com",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Exo', fontSize: 24),
            ),
          ),
          Text(
            "SUCESSO",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 48,
                letterSpacing: 1,
                fontFamily: 'Exo'),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Utilize sua nova senha em suas compras a partir de agora.",
            style: TextStyle(color: Colors.grey[200]),
          ),
          SizedBox(
            height: 32,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SvgPicture.asset(
              "assets/images/BG_Sucesso.svg",
            ),
          ),
          SizedBox(
            height: 32,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: GenericButton(
              haveToReturnContext: false,
              text: "Ir para carteira",
              onPressedFunction: () {
                Get.offAndToNamed(Routes.MAIN_PAGES_HOLDER);
              },
              txtColor: Colors.white,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
    );
  }
}
