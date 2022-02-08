import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/block_virtual_card/block_vitual_card_password_step_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VirtualCardBlockPasswordStep extends StatefulWidget {
  @override
  _VirtualCardBlockPasswordStepState createState() =>
      _VirtualCardBlockPasswordStepState();
}

class _VirtualCardBlockPasswordStepState
    extends State<VirtualCardBlockPasswordStep> {
  final VirtualCardBlockPasswordController _controller =
      Get.find<VirtualCardBlockPasswordController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: secondaryColor,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: _controller.action == "lock"
                  ? "Bloquear cartão"
                  : _controller.action == "delete"
                      ? "Excluir cartão"
                      : "Desbloquear cartão",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  normalText: "do seu cartão",
                  customText: "Informe a senha númerica",
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
                BottomButton(
                  txt: "Continuar",
                  onTap: () => _controller.formKey.currentState?.validate() ?? false
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
