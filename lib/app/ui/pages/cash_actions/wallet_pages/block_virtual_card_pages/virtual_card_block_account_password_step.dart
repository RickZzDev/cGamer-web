import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/block_virtual_card/block_vitual_card_account_password_step_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VirtualCardBlockAccountPasswordStep extends StatefulWidget {
  @override
  _VirtualCardBlockAccountPasswordStepState createState() =>
      _VirtualCardBlockAccountPasswordStepState();
}

class _VirtualCardBlockAccountPasswordStepState
    extends State<VirtualCardBlockAccountPasswordStep> {
  final VirtualCardBlockAccountPassowordController _controller =
      Get.find<VirtualCardBlockAccountPassowordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      normalText2: "da",
                      customText2: "sua conta",
                      normalText3: _controller.action == "lock"
                          ? "para bloquear o seu"
                          : _controller.action == "delete"
                              ? "para excluir o seu"
                              : "para desbloquear o seu",
                      customText3: "cartão virtual",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Form(
                        key: _controller.formKey,
                        child: CustomTextField(
                          labelText: "Senha",
                          labelStyle: textStyle,
                          hintStyle: textStyle.copyWith(fontSize: 14),
                          autoFocus: false,
                          obscureText: true,
                          controller: _controller.passwordController,
                          validation: _controller.validatePassword,
                        )),
                    BottomButton(
                        txt: _controller.action == "lock"
                            ? "Bloquear"
                            : _controller.action == "delete"
                                ? "Excluir"
                                : "Desbloquear",
                        onTap: () => _controller.formKey.currentState?.validate() ?? false
                            ? _controller.action == "lock"
                                ? _controller.blockVirtualCard()
                                : _controller.action == "delete"
                                    ? _controller.deleteVirtualCard()
                                    : _controller.unblockVirtualCard()
                            : SnackBarUtils.showSnackBar(
                                desc: "Preencha corretamente o campo acima.",
                                title: "Atenção"))
                  ],
                ),
              ),
            )));
  }
}
