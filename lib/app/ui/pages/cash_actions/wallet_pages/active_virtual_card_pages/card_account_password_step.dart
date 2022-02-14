import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/add_vitual_card_account_password_step.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddCardAccountPasswordStep extends StatefulWidget {
  @override
  _AddCardAccountPasswordStepState createState() =>
      _AddCardAccountPasswordStepState();
}

class _AddCardAccountPasswordStepState
    extends State<AddCardAccountPasswordStep> {
  final VirtualCardAccountPassowordController _controller =
      Get.find<VirtualCardAccountPassowordController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: secondaryColor,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(
                appBarTxt: "Cartão Virtual",
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
                          normalText: "Informe a",
                          customText: "senha",
                          normalText2: _controller.origin == "wallet_header"
                              ? "do"
                              : "da",
                          customText2: _controller.origin == "wallet_header"
                              ? "seu cartão"
                              : "sua conta",
                          normalText3: _controller.origin == "wallet_header"
                              ? "para visualizar os seus dados"
                              : "para ativar o seu",
                          customText3: _controller.origin == "wallet_header"
                              ? ""
                              : "cartão virtual",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Form(
                            key: _controller.formKey,
                            child: _controller.origin == "wallet_header"
                                ? CustomTextField(
                                    labelText: "Senha",
                                    hintText: "4 números não sequenciais",
                                    labelStyle: textStyle,
                                    hintStyle: textStyle.copyWith(fontSize: 14),
                                    maxLength: 4,
                                    validateMode: AutovalidateMode.disabled,
                                    type: TextInputType.number,
                                    obscureText: true,
                                    autoFocus: false,
                                    validation:
                                        _controller.validateCardPassword,
                                    controller: _controller.passwordController,
                                  )
                                : CustomTextField(
                                    labelText: "Senha",
                                    labelStyle: textStyle,
                                    hintStyle: textStyle.copyWith(fontSize: 14),
                                    autoFocus: false,
                                    obscureText: true,
                                    controller: _controller.passwordController,
                                    validation: _controller.validatePassword,
                                  )),
                        BottomButton(
                            txt: _controller.origin != null
                                ? "Avançar"
                                : "Ativar",
                            onTap: () => _controller.formKey.currentState?.validate() ?? false
                                ? _controller.origin != null
                                    ? _controller.getCardPCIData()
                                    : _controller.activateVirtualCard()
                                : SnackBarUtils.showSnackBar(
                                    desc:
                                        "Preencha corretamente o campo acima.",
                                    title: "Atenção"))
                      ],
                    ),
                  ),
                ))));
  }
}
