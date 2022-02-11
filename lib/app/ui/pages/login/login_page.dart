import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/login/login_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/login_components/box_account.dart';
import 'package:cGamer/app/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginController _loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        systemNavigationBarColor: primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image.asset(
                        "assets/images/logo/logo_gray1.png"),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _loginController.logged.value ? true : false,
                      child: BoxAccountLogin(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 44,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: GenericButton(
                      haveToReturnContext: true,
                      text: "Entrar",
                      onPressedFunction: _loginController.loginModalBottomSheet,
                      icon: Icons.check,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => Visibility(
                      visible: _loginController.logged.value ? false : true,
                      child: SizedBox(
                        height: 44,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: GenericButton(
                          color: Theme.of(context).accentColor,
                          text: "Nova Conta",
                          txtColor: Colors.white,
                          icon: Icons.person_add_alt_1_outlined,
                          onPressedFunction: () =>
                              Get.toNamed(Routes.SINGUP_NAME_CPF_STEP),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/BG_Gamers.svg",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _loginController.goPrivacyPolices();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(4.0),
                child: Text('Políticas de privacidade',
                    style: TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
