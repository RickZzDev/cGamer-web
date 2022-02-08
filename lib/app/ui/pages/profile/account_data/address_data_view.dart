import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/account_data/address_data_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddressDataView extends StatefulWidget {
  @override
  _AddressDataViewState createState() => _AddressDataViewState();
}

class _AddressDataViewState extends State<AddressDataView> {
  final AddressDataController _controller = Get.find<AddressDataController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller.formKey = formKey;
    super.initState();
  }

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
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              normalText: '', customText: "Endereço"),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: CustomTextField(
                              controller: _controller.cepController,
                              validation: _controller.cepValidation,
                              onChange: (value) => _controller
                                  .onCepTxtChange(value, context: context),
                              labelText: "CEP",
                              type: TextInputType.number,
                              validateMode: AutovalidateMode.onUserInteraction,
                              autoFocus: false,
                              sufixIcon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: CustomTextField(
                              controller: _controller.logradouroController,
                              labelText: "Logradouro",
                              validateMode: AutovalidateMode.onUserInteraction,
                              autoFocus: false,
                              enabled:
                                  _controller.isEnableField['logradouro'] ??
                                      false,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          96,
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: CustomTextField(
                                      controller: _controller.numberController,
                                      type: TextInputType.number,
                                      validateMode:
                                          AutovalidateMode.onUserInteraction,
                                      labelText: "Número",
                                      autoFocus: false,
                                      enabled: true,
                                      sufixIcon: Icon(Icons.edit,
                                          color: Theme.of(context).primaryColor)
                                      // onChange: () => _formKey.currentState.validate(),
                                      ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) +
                                          24,
                                  margin: EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: CustomTextField(
                                      controller:
                                          _controller.complementController,
                                      type: TextInputType.text,
                                      validateMode:
                                          AutovalidateMode.onUserInteraction,
                                      labelText: "Complemento (Opcional)",
                                      autoFocus: false,
                                      enabled: true,
                                      sufixIcon: Icon(Icons.edit,
                                          color: Theme.of(context).primaryColor)
                                      // onChange: () => _formKey.currentState.validate(),
                                      ),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(
                              top: 16,
                            ),
                            child: CustomTextField(
                              controller: _controller.districtDateController,
                              type: TextInputType.name,
                              validateMode: AutovalidateMode.onUserInteraction,
                              labelText: "Bairro",
                              autoFocus: false,
                              enabled:
                                  _controller.isEnableField['bairro'] ?? false,
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
                                    controller: _controller.cityController,
                                    type: TextInputType.text,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    labelText: "Cidade",
                                    autoFocus: false,
                                    enabled:
                                        _controller.isEnableField['cidade'] ??
                                            false,
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
                                    controller: _controller.ufController,
                                    type: TextInputType.text,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    labelText: "UF",
                                    autoFocus: false,
                                    enabled: _controller.isEnableField['uf'] ??
                                        false,
                                    // onChange: () => _formKey.currentState.validate(),
                                  ),
                                ),
                              ]),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GenericButton(
                                  text: _controller.origin == "profile"
                                      ? "Atualizar endereço"
                                      : "Continuar",
                                  haveToReturnContext: false,
                                  onPressedFunction: () =>
                                      formKey.currentState?.validate() ?? false
                                          ? _controller.updateAddress(
                                              context: context)
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
