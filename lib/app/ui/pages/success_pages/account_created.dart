import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';

class AccountCreatedSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 80),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Parabéns",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  fontFamily: 'Exo'),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              child: Text(
                Get.arguments['username'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Exo', fontSize: 24),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Você acaba de se transformar\nem um gamer com super poderes!!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200], fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              // width: MediaQuery.of(context).size.width * 0.9,
              // height: 350,
              child: SvgPicture.asset(
                "assets/images/BG_Parabens.svg",
                fit: BoxFit.contain,
                // height: 350,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(32),
              // height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: GenericButton(
                    text: "Entrar",
                    onPressedFunction: () =>
                        Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                    txtColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
