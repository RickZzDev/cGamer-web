import 'package:cGamer/app/controllers/signup/complete_register/adress_complement_controller.dart';
import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdressComplementPage extends StatelessWidget {
  final AdressComplementController _controller =
      Get.find<AdressComplementController>();

  @override
  Widget build(BuildContext context) {
    CompleteRegisterPayload previousPayload = Get.arguments["payload"];

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
              appBarTxt: "Endereço",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _controller.formKeyAdressComplement,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Theme.of(context).accentColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRichText(
                        normalText: "Confira os campos abaixo com",
                        customText: "seu endereço atual",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomTextField(
                        enabled: previousPayload.address?.district == null ||
                                previousPayload.address!.district!.isEmpty
                            ? true
                            : false,
                        labelText: "Endereço",
                        validateMode: AutovalidateMode.onUserInteraction,
                        controller: _controller.adressController,
                        validation: _controller.validateEmpty,
                        autoFocus: previousPayload.address?.district == null ||
                                previousPayload.address!.district!.isEmpty
                            ? true
                            : false,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: CustomTextField(
                              labelText: "Número",
                              autoFocus: previousPayload.address?.district ==
                                          null ||
                                      previousPayload.address!.district!.isEmpty
                                  ? false
                                  : true,
                              controller: _controller.numberController,
                              validation: _controller.validateEmpty,
                              type: TextInputType.number,
                              validateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          SizedBox(
                            // height: 40,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: CustomTextField(
                              labelText: "Complemento (Opcional)",
                              validateMode: AutovalidateMode.onUserInteraction,
                              controller: _controller.complementTxtController,
                              autoFocus: false,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      CustomTextField(
                        // enabled: _controller.havePreviousData ? false : true,
                        enabled: previousPayload.address?.district == null ||
                                previousPayload.address!.district!.isEmpty
                            ? true
                            : false,
                        labelText: "Bairro",
                        controller: _controller.districtController,
                        validation: _controller.validateEmpty,
                        validateMode: AutovalidateMode.onUserInteraction,

                        autoFocus: false,
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () => _controller
                                            .formKeyAdressComplement
                                            .currentState
                                            ?.validate() ??
                                        false
                                    ? _controller.changePage()
                                    : print("INVALID"),
                                txtColor: Colors.white),
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
