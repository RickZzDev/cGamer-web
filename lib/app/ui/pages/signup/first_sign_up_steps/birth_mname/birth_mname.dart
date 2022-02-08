import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/signup/fisrt_register/birth_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';

class BirthPage extends StatefulWidget {
  @override
  _BirthPageState createState() => _BirthPageState();
}

class _BirthPageState extends State<BirthPage> {
  final BirthController _controller = Get.find<BirthController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.formKey = formKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
          body: KeyboardIsOpen.verify(context)
              ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    height: screenHeigthSize,
                    width: screenWidthhSize,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRichText(
                                    normalText: "Me diz ai, quando foi que",
                                    customText: "você nasceu?"),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  labelText: "Digite sua data de nascimento",
                                  controller: _controller.dateController,
                                  type: TextInputType.number,
                                  validateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validation: _controller.validateDate,
                                  autoFocus: false,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Exemplo: DD/MM/YYYY",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "É necessário ter no mínimo 16 anos para se cadastrar.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                // SizedBox(
                                //   height: 36,
                                // ),
                                // CustomRichText(
                                //   normalText: "E o nome completo",
                                //   customText: "da sua mãe?",
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // CustomTextField(
                                //   labelText: "Nome completo da sua mãe",
                                //   validation: _controller.validateMotherName,
                                //   controller: _controller.mothernameController,
                                //   validateMode:
                                //       AutovalidateMode.onUserInteraction,
                                //   type: TextInputType.name,
                                //   textCapitalization: TextCapitalization.words,
                                //   autoFocus: false,
                                // ),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //   "Idêntico como consta no seu documento",
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontWeight: FontWeight.w300),
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GenericButton(
                                  text: "Avançar",
                                  haveToReturnContext: false,
                                  onPressedFunction: () => _controller
                                          .formKey.currentState
                                          .validate()
                                      ? _controller.changePage()
                                      : null,
                                  txtColor: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(32),
                  height: screenHeigthSize,
                  width: screenWidthhSize,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRichText(
                                  normalText: "Me diz ai, quando foi que",
                                  customText: "você nasceu?"),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                labelText: "Digite sua data de nascimento",
                                controller: _controller.dateController,
                                type: TextInputType.number,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                                validation: _controller.validateDate,
                                autoFocus: false,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Exemplo: DD/MM/YYYY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "É necessário ter no mínimo 16 anos para se cadastrar.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              // SizedBox(
                              //   height: 36,
                              // ),
                              // CustomRichText(
                              //   normalText: "E o nome completo",
                              //   customText: "da sua mãe?",
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // CustomTextField(
                              //   labelText: "Nome completo da sua mãe",
                              //   validation: _controller.validateMotherName,
                              //   controller: _controller.mothernameController,
                              //   validateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   type: TextInputType.name,
                              //   textCapitalization: TextCapitalization.words,
                              //   autoFocus: false,
                              // ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              // Text(
                              //   "Idêntico como consta no seu documento",
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w300),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () =>
                                    _controller.formKey.currentState.validate()
                                        ? _controller.changePage()
                                        : null,
                                txtColor: Colors.white,
                              ),
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
