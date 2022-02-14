import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/virtual_card_password_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsActualPage extends StatelessWidget {
  final VirtualCardPasswordController _controller =
      Get.find<VirtualCardPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Alterar Senha",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              normalText: "Informe a",
              customText: "senha",
              normalText2: "da",
              customText2: "sua conta",
              normalText3: "para trocar a senha do seu",
              customText3: "cartão virtual",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              labelText: "Senha",
              labelStyle: textStyle,
              hintStyle: textStyle.copyWith(fontSize: 14),
              obscureText: true,
              controller: _controller.passwordController,
            ),
            BottomButton(
                txt: "Avançar",
                onTap: () =>
                    _controller.passwordController.value.text.isNotEmpty
                        ? Get.toNamed(Routes.WALLET_SETTINGS_PASSWORD_NEW,
                            arguments: {
                                'accountPassword': SecurityUtils.encodeTo64(
                                    _controller.passwordController.value.text)
                              })
                        : SnackBarUtils.showSnackBar(
                            desc: "Preencha corretamente o campo acima.",
                            title: "Atenção"))
          ],
        ),
      ),
    );
  }
}
