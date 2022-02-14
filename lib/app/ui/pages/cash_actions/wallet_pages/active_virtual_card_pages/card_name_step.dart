import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/add_virtual_card_name_step_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardNameStep extends StatefulWidget {
  @override
  _AddCardNameStepState createState() => _AddCardNameStepState();
}

class _AddCardNameStepState extends State<AddCardNameStep> {
  final VirtualCardNameStepController _controller =
      Get.find<VirtualCardNameStepController>();

  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();

  @override
  void initState() {
    _controller.formKey = _formKey;
    _controller.nameController = _nameController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // DESCOMENTAR
      // resizeToAvoidBottomPadding: false,
      backgroundColor: secondaryColor,
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
              normalText: "que será usado nas suas transações",
              customText: "Digite o nome",
              customFirst: true,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16,
            ),
            Form(
                key: _controller.formKey,
                child: CustomTextField(
                  labelText: "Máximo 19 caracteres",
                  maxLength: 19,
                  controller: _controller.nameController,
                  validation: _controller.validateName,
                  autoFocus: false,
                )),
            SizedBox(
              height: 16,
            ),
            CustomRichText(
              normalText: "Com o",
              customText: "cartão virtual",
              normalText2: "você compra online movimentando o",
              customText2: "dinheiro da sua conta",
              normalText3: "e pode bloquear, excluir e",
              customText3: "ativar um novo em segundos.",
              textAlign: TextAlign.start,
            ),
            BottomButton(
              txt: "Avançar",
              onTap: () => _controller.formKey.currentState.validate()
                  ? _controller.goNextPage()
                  : SnackBarUtils.showSnackBar(
                      desc: "Preencha corretamente o campo acima.",
                      title: "Atenção"),
            )
          ],
        ),
      ),
    );
  }
}
