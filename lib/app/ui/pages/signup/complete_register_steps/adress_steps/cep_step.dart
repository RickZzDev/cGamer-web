import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/signup/complete_register/cep_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CepStepPage extends StatefulWidget {
  @override
  _CepStepPageState createState() => _CepStepPageState();
}

class _CepStepPageState extends State<CepStepPage> {
  final CepController _controller = Get.find<CepController>();

  @override
  void initState() {
    _controller.payload = Get.arguments["payload"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.validatingCep.value,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ), // color: ,
          color: Colors.black,

          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).accentColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: CustomAppBar(
                  appBarTxt: "Endereço",
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(32),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(
                            normalText: "Qual é o",
                            customText: "CEP de onde você mora?"),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _controller.formKey,
                          child: CustomTextField(
                            labelText: "CEP",
                            type: TextInputType.number,
                            controller: _controller.cepTxtController,
                            validation: _controller.cepValidation,
                            onChange: _controller.onCepTxtChange,
                            validateMode: AutovalidateMode.onUserInteraction,
                            autoFocus: true,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                GenericButton(
                                    text: "Avançar",
                                    haveToReturnContext: false,
                                    onPressedFunction: () => _controller
                                                .formKey.currentState
                                                ?.validate() ??
                                            false
                                        ? _controller.changeToComplement()
                                        : print("INVALID"),
                                    // onPressedFunction: () => _controller.onloading(context),
                                    txtColor: Colors.white),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
