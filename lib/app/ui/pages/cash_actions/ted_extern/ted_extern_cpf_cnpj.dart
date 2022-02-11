import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_cash_out_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TedExternCpfCnpjView extends StatelessWidget {
  final TedExternIdentifierController _controller =
      Get.find<TedExternIdentifierController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: utils.secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(appBarTxt: "Transferir"),
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Obx(
                  () => CustomRichText(
                    textAlign: TextAlign.start,
                    normalText: "Qual o ",
                    customText: "CPF ou CNPJ",
                    normalText2: "de quem",
                    customText2:
                        "você vai enviar ${_controller.tedInfo.value.ammount}",
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Form(
                  key: _controller.formKey,
                  child: CustomTextField(
                    autoFocus: false,
                    labelText: "CPF/CNPJ",
                    controller: _controller.textController,
                    onChange: _controller.inputField,
                    type: TextInputType.number,
                    validation: Validations().validateCpfOrCpnj,
                    validateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        GenericButton(
                            text: "Avançar",
                            haveToReturnContext: false,
                            onPressedFunction: () =>
                                _controller.formKey.currentState?.validate() ??
                                        false
                                    ? _controller.changePage()
                                    : DoNothingAction(),
                            txtColor: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
