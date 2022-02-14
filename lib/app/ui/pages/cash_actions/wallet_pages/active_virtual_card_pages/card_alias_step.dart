import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/add_virtual_card_alias_step_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardAliasStep extends StatefulWidget {
  @override
  _AddCardAliasStepState createState() => _AddCardAliasStepState();
}

class _AddCardAliasStepState extends State<AddCardAliasStep> {
  final VirtualCardAliasStepController _controller =
      Get.find<VirtualCardAliasStepController>();

  var _formKey = GlobalKey<FormState>();
  var _aliasController = TextEditingController();

  @override
  void initState() {
    _controller.aliasController = _aliasController;
    _controller.formKey = _formKey;

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
              normalText: "do seu cartão virtual",
              customText: "Informe o apelido",
              customFirst: true,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16,
            ),
            Form(
                key: _controller.formKey,
                child: CustomTextField(
                  labelText: "Máximo 15 caracteres",
                  maxLength: 15,
                  controller: _controller.aliasController,
                  validation: _controller.validateAlias,
                  textCapitalization: TextCapitalization.words,
                )),
            SizedBox(
              height: 16,
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
