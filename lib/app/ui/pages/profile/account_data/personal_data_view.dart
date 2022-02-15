import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/account_data/personal_data_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PersonalDataView extends StatefulWidget {
  @override
  _PersonalDataViewState createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  final PersonalDataController _controller = Get.find<PersonalDataController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: primaryColor,
        ),
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: CustomAppBar(
                  appBarTxt: "Dados da conta",
                ),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              normalText: '', customText: "Dados pessoais"),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: CustomTextField(
                              controller: _controller.nickController,
                              validation: _controller.validateNick,
                              labelText: "Como gostaria de ser chamado?",
                              type: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              validateMode: AutovalidateMode.onUserInteraction,
                              autoFocus: false,
                              sufixIcon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: CustomTextField(
                                controller: _controller.userNameController,
                                validation: _controller.validateUsername,
                                labelText: "Nome de usuário (@)",
                                type: TextInputType.text,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                                autoFocus: false,
                                sufixIcon: Icon(Icons.edit,
                                    color: Theme.of(context).primaryColor)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 16,
                            ),
                            child: CustomTextField(
                                controller: _controller.momNameController,
                                validation: _controller.validateMomName,
                                type: TextInputType.name,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization: TextCapitalization.words,
                                labelText: "Nome Da Mãe",
                                autoFocus: false,
                                sufixIcon: Icon(Icons.edit,
                                    color: Theme.of(context).primaryColor)
                                // onChange: () => _formKey.currentState.validate(),
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 16,
                            ),
                            child: CustomTextField(
                                controller: _controller.nameController,
                                validation: _controller.validateName,
                                type: TextInputType.name,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                                textCapitalization: TextCapitalization.words,
                                labelText: "Nome completo",
                                autoFocus: false,
                                sufixIcon: Icon(Icons.edit,
                                    color: Theme.of(context).primaryColor)
                                // onChange: () => _formKey.currentState.validate(),
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 16,
                            ),
                            child: CustomTextField(
                              controller: _controller.emailController,
                              type: TextInputType.text,
                              validateMode: AutovalidateMode.onUserInteraction,
                              labelText: "E-mail",
                              autoFocus: false,
                              enabled: false,
                              // onChange: () => _formKey.currentState.validate(),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          24,
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: CustomTextField(
                                    controller: _controller.cpfController,
                                    type: TextInputType.number,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    labelText: "CPF",
                                    autoFocus: false,
                                    enabled: false,
                                    // onChange: () => _formKey.currentState.validate(),
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          48,
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: CustomTextField(
                                    controller: _controller.birthDateController,
                                    type: TextInputType.number,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    labelText: "Data de nascimento",
                                    autoFocus: false,
                                    enabled: false,
                                    // onChange: () => _formKey.currentState.validate(),
                                  ),
                                ),
                              ]),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GenericButton(
                                  text: "Atualizar dados",
                                  haveToReturnContext: false,
                                  onPressedFunction: () =>
                                      _formKey.currentState?.validate() ?? false
                                          ? _controller.updateProfile()
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
                ),
              ),
            ))));
  }
}
