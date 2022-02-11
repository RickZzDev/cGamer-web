import 'package:cGamer/app/controllers/wallet_controllers/add_edit_extern_card/add_edit_card_second_step_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExternCardSecondStep extends StatelessWidget {
  final AddEditCardSecondStepController _controller =
      Get.find<AddEditCardSecondStepController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Cartão de crédito",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    normalText: "para o cartão",
                    customText: "Apelido",
                    customFirst: true,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(labelText: "Apelido"),
                  SizedBox(
                    height: 12,
                  ),
                  CustomRichText(
                    normalText: "Digite o",
                    customText: "CPF",
                    normalText2: "do titular",
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    labelText: "CPF",
                    controller: _controller.cpfTextController,
                    type: TextInputType.number,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: SizedBox(
                      child: GenericButton(
                        text: "Cadastrar cartão",
                        onPressedFunction: () =>
                            Get.toNamed(Routes.WALLET_ADD_EXTERN_CARD_SUCCESS),
                        txtColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
