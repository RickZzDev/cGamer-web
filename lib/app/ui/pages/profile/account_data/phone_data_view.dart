import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/account_data/phone_data_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneDataView extends StatefulWidget {
  @override
  _PhoneDataViewState createState() => _PhoneDataViewState();
}

class _PhoneDataViewState extends State<PhoneDataView> {
  final PhoneDataController _controller = Get.find<PhoneDataController>();
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              normalText: '', customText: "Telefone"),
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: CustomTextField(
                              controller: _controller.phoneController,
                              labelText: "Celular",
                              validateMode: AutovalidateMode.onUserInteraction,
                              type: TextInputType.number,
                              autoFocus: false,
                              sufixIcon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GenericButton(
                                  text: "Atualizar telefone",
                                  haveToReturnContext: false,
                                  onPressedFunction: () =>
                                      (_formKey.currentState?.validate() ??
                                                  false) &&
                                              _controller.validatePhoneField()
                                          ? _controller.updatePhone()
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
