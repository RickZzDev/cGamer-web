import 'package:cGamer/app/controllers/cash_actions_controllers/deposit_value_in_out/deposit_value_controller.dart';
import 'package:cGamer/app/ui/components/cash_in_components/tax_box_component.dart';
import 'package:cGamer/app/ui/components/cash_in_components/value_card.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DepositValueView extends StatefulWidget {
  @override
  _DepositValueViewState createState() => _DepositValueViewState();
}

class _DepositValueViewState extends State<DepositValueView> {
  final DepositValueController _controller = Get.find<DepositValueController>();
  var formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: themes.primaryColor,
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: themes.secondaryColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: CustomAppBar(
                  appBarTxt: _controller.defineAppBarText(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.defineCustomText(),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: CustomTextField(
                          focusNode: _controller.focusNode,
                          fontSize: 24,
                          autoFocus: false,
                          controller: _controller.moneyController.value,
                          validation: _controller.validateBalance,
                          validateMode: AutovalidateMode.onUserInteraction,
                          labelText: "Valor",
                          labelStyle: themes.textStyle.copyWith(fontSize: 18),
                          type: TextInputType.number,
                          onChange: _controller.onChangeCalc,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _controller.displayValue(index),
                              child: ValueCard(
                                  number: _controller.arrayNumbers[index]),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 5,
                          ),
                          itemCount: 5,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: TaxBox(
                            txt: _controller.defineTaxBoxTxt(),
                            depositValue: _controller.moneyValue.value,
                            taxValue: _controller.taxValue.value,
                            valueToReceive: _controller.totalReceive,
                            typeTransferTxt: _controller.type.value != 'deposit'
                                ? "Transferir"
                                : "Depósito",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(
                                () => GenericButton(
                                  text: _controller.defineTextButton(),
                                  haveToReturnContext: false,
                                  onPressedFunction: () =>
                                      formKey.currentState.validate()
                                          ? _controller.defineRoute()
                                          : DoNothingAction(),
                                  txtColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
