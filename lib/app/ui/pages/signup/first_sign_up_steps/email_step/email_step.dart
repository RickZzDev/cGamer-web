import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/signup/fisrt_register/signup_email_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';

class EmailStepPage extends StatefulWidget {
  @override
  _EmailStepPageState createState() => _EmailStepPageState();
}

class _EmailStepPageState extends State<EmailStepPage> {
  final SignUpEmailStepController _controller =
      Get.find<SignUpEmailStepController>();
  var formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.white, fontFamily: 'Exo'),
                    children: <TextSpan>[
                      TextSpan(text: 'Insira o seu'),
                      TextSpan(
                          text: ' e-mail de acesso pessoal',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: Form(
                    key: formKey,
                    child: CustomTextField(
                      controller: _controller.emailController,
                      validation: _controller.validateEmail,
                      validateMode: AutovalidateMode.onUserInteraction,
                      labelText: "E-mail",
                      type: TextInputType.emailAddress,
                      autoFocus: true,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Obx(
                        () => Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: _controller.checkBoxValue.value,
                          onChanged: (_value) =>
                              _controller.setCheckBox(_value),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          GenericUtils.goTermsUse(
                              "https://joggabank.com.br/termos-de-uso/");
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontFamily: 'Exo'),
                            children: <TextSpan>[
                              TextSpan(text: 'Eu li e aceito os '),
                              TextSpan(
                                text: 'termos e condições',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontFamily: 'Exo'),
                          children: <TextSpan>[
                            TextSpan(text: 'Você possui'),
                            TextSpan(
                                text: ' código de indicação?',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Obx(() => Switch(
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: _controller.onChangedSwitch,
                            value: _controller.switchValue.value,
                          ))
                    ]),
                Obx(() => _controller.switchValue.value
                    ? Container(
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: CustomTextField(
                          controller: _controller.codeController,
                          validation: _controller.validateCode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          labelText: "Código de indicação",
                          type: TextInputType.text,
                          autoFocus: true,
                        ),
                      )
                    : Container()),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () => _controller
                                  .validateAllForm(formKey)
                              ? _controller.changePage()
                              : SnackBarUtils.showSnackBar(
                                  title: "Atenção",
                                  desc:
                                      "Por favor aceite os termos e condições para seguir."),
                          txtColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
