import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SuccesRecoveredPage extends StatefulWidget {
  @override
  _SuccesRecoveredPageState createState() => _SuccesRecoveredPageState();
}

class _SuccesRecoveredPageState extends State<SuccesRecoveredPage> {
  bool isChangePasswordFlow = false;

  @override
  void initState() {
    super.initState();
    isChangePasswordFlow =
        Get.arguments != null && Get.arguments["retrive_password"] == false
            ? true
            : false;
  }

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
            isChangePasswordFlow
                ? "Utilize sua nova senha no "
                : "Faça o login com sua nova ",
            style: TextStyle(color: Colors.grey[200]),
          ),
          Text(
            isChangePasswordFlow ? "seu próximo acesso." : "senha para entrar.",
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
              text: isChangePasswordFlow ? "Voltar ao Início" : "Fazer login",
              onPressedFunction: () {
                isChangePasswordFlow
                    ? Get.offAndToNamed(Routes.MAIN_PAGES_HOLDER)
                    : Get.offNamed(Routes.LOGIN);
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
