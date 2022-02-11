import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/create_password_virtual_card_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SettingsNewPage extends StatelessWidget {
  final CreateVirtualCardPassowordController _controller =
      Get.find<CreateVirtualCardPassowordController>();

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
                appBarTxt: "Alterar Senha",
              ),
            ),
            body: Obx(() => ModalProgressHUD(
                  inAsyncCall: _controller.loading.value,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(
                          normalText: "do seu cartão",
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
                              controller: _controller.newPasswordController,
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Para a sua segurança, evite usar seu ano de nascimento ou de seus familiares",
                          style: textStyle.copyWith(fontSize: 15),
                        ),
                        BottomButton(
                          txt: "Alterar senha",
                          onTap: () => _controller.formKey.currentState
                                      ?.validate() ??
                                  false
                              ? _controller.goNextPage()
                              : SnackBarUtils.showSnackBar(
                                  desc: "Preencha corretamente o campo acima.",
                                  title: "Atenção"),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
