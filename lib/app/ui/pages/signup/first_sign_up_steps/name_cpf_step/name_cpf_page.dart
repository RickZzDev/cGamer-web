import 'package:cGamer/app/controllers/signup/fisrt_register/name_cpf_step_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameCpfStepPage extends StatefulWidget {
  @override
  _NameCpfStepPageState createState() => _NameCpfStepPageState();
}

class _NameCpfStepPageState extends State<NameCpfStepPage> {
  final NameCpfStepController _controller = Get.find<NameCpfStepController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).accentColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Dados pessoais",
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => _controller.defineCustomText(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 28, bottom: 48),
                        child: CustomTextField(
                          controller: _controller.nameController,
                          validation: _controller.validateName,
                          labelText: _controller.fromTed.value
                              ? _controller.tedInfo.value.cpf == null
                                  ? "Razão Social"
                                  : "Nome completo"
                              : "Seu nome completo",
                          validateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          autoFocus: false,
                        ),
                      ),
                      !_controller.fromTed.value
                          ? CustomRichText(
                              normalText: "E o seu",
                              customText: "CPF?",
                              textAlign: TextAlign.start,
                            )
                          : SizedBox(),
                      !_controller.fromTed.value
                          ? Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: CustomTextField(
                                controller: _controller.cpfController,
                                validation: _controller.validateCpf,
                                type: TextInputType.number,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                                labelText: "Seu CPF",
                                autoFocus: false,
                              ),
                            )
                          : SizedBox(),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GenericButton(
                              text: "Avançar",
                              haveToReturnContext: false,
                              onPressedFunction: () =>
                                  _controller.defineRoute(),
                              txtColor: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
