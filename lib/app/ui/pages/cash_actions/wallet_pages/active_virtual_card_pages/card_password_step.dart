import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/add_virtual_card_create_password_step.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardPasswordStep extends StatelessWidget {
  final VirtualCardCreatePasswordController _controller =
      Get.find<VirtualCardCreatePasswordController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: secondaryColor,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Cartão Virtual",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  normalText: "para seu cartão",
                  customText: "Digite a nova senha",
                  customFirst: true,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16,
                ),
                Form(
                    key: _controller.formKey,
                    child: CustomTextField(
                      labelText: "Senha",
                      hintText: "4 números não sequenciais",
                      labelStyle: textStyle,
                      hintStyle: textStyle.copyWith(fontSize: 14),
                      maxLength: 4,
                      type: TextInputType.number,
                      obscureText: true,
                      autoFocus: false,
                      validation: _controller.validatePassword,
                      controller: _controller.passwordController,
                    )),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Para a sua segurança, evite usar seu ano de nascimento ou de seus familiares.",
                  style: textStyle.copyWith(fontSize: 14),
                ),
                BottomButton(
                  txt: "Continuar",
                  onTap: () =>
                      _controller.formKey.currentState?.validate() ?? false
                          ? _controller.goNextPage()
                          : SnackBarUtils.showSnackBar(
                              desc: "Preencha corretamente o campo acima.",
                              title: "Atenção"),
                )
              ],
            ),
          ),
        ));
  }
}
