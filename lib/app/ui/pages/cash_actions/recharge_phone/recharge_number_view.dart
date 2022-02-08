import 'package:cGamer/app/controllers/recharge_phone/recharge_number_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/add_contact_button.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RechargeNumberView extends StatefulWidget {
  @override
  _RechargeNumberViewState createState() => _RechargeNumberViewState();
}

class _RechargeNumberViewState extends State<RechargeNumberView> {
  final RechargeNumberController _controller =
      Get.find<RechargeNumberController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: utils.secondaryColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomAppBar(
                appBarTxt: "Recarga de celular",
              ),
            ),
            body: SafeArea(
                child: Obx(() => ModalProgressHUD(
                      progressIndicator: CircularProgressIndicator(
                        backgroundColor: utils.primaryColor,
                      ),
                      inAsyncCall: _controller.loading.value,
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRichText(
                              normalText: "Qual",
                              customText: "número",
                              normalText2: "você quer",
                              customText2: "recarregar?",
                              textAlign: TextAlign.start,
                            ),
                            CustomTextField(
                              labelText: "",
                              type: TextInputType.number,
                              controller: _controller.phoneController,
                              onChange: _controller.onChangePhone,
                              autoFocus: false,
                              maxLength: 15,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            CustomRichText(
                              normalText: "",
                              customText: "Apelido",
                              customFirst: true,
                            ),
                            CustomTextField(
                              labelText: "",
                              onChange: _controller.onChangeNickValue,
                              type: TextInputType.text,
                              controller: _controller.nickController,
                              autoFocus: false,
                            ),
                            Obx(() => Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: AddContactsButton(
                                    completed: _controller
                                        .hasCompletedSaveContact.value,
                                    onTap: () =>
                                        _controller.enabledSaveContact.value &&
                                                _controller
                                                    .enabledNickContact.value &&
                                                !_controller
                                                    .hasCompletedSaveContact
                                                    .value
                                            ? _controller.saveContact()
                                            : DoNothingAction(),
                                    enabled: _controller
                                            .enabledSaveContact.value &&
                                        _controller.enabledNickContact.value))),
                            Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Text(
                                  "Contatos",
                                  style: utils.textStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Obx(
                              () => _controller.defineWidgetToDisplay(),
                            ),
                            Expanded(
                              child: Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GenericButton(
                                    text: "Avançar",
                                    haveToReturnContext: false,
                                    onPressedFunction: () => _controller
                                            .enabledSaveContact.value
                                        ? _controller.changePage()
                                        : SnackBarUtils.showSnackBar(
                                            title: "Atenção",
                                            desc:
                                                "Preencha corretamente todos os campos."),
                                    txtColor: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )))));
  }
}
