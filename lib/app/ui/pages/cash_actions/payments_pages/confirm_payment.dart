import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/confirm_payment.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ConfirmBillPaymentPage extends StatefulWidget {
  @override
  _ConfirmBillPaymentPageState createState() => _ConfirmBillPaymentPageState();
}

class _ConfirmBillPaymentPageState extends State<ConfirmBillPaymentPage> {
  final ConfirmBillPaymentController _controller =
      Get.find<ConfirmBillPaymentController>();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

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
              appBarTxt: "Pagar boleto",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CustomRichText(
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      customFirst: false,
                      customText: "para efetuar o pagamento",
                      normalText: "Confirme os dados",
                      // customFirst: true,
                    ),
                  ),
                ),
                Container(
                  constraints:
                      BoxConstraints(minHeight: utils.screenHeigthSize * 0.85),
                  // height: utils.screenHeigthSize,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: utils.primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Valor a ser pago",
                          style: utils.textStyle.copyWith(
                            color: utils.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _controller.formKey,
                          child: CustomTextField(
                            labelText: "",
                            controller: _controller.balanceAvailableController,
                            disabledTextColor: utils.secondaryColor,
                            sufixIcon: _controller.model.allowEditAmount ??
                                    false
                                ? Icon(Icons.edit, color: utils.secondaryColor)
                                : null,
                            fontSize: 20,
                            autoFocus: false,
                            isBold: true,
                            enabled: _controller.model.allowEditAmount ?? false
                                ? true
                                : false,
                            type: TextInputType.number,
                            validation: _controller.validateAmmountToPay,
                            txtColor: utils.secondaryColor,
                            borderEnabledColor: utils.secondaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Obx(
                          () => _controller.hasCompletedBalanceRequest.value
                              ? CustomRichText(
                                  normalText: "Seu saldo",
                                  customText:
                                      "${_controller.balanceModel.balanceAvailable?.available}",
                                  textAlign: TextAlign.start,
                                  color: utils.secondaryColor)
                              : Shimmer.fromColors(
                                  baseColor: utils.primaryColor,
                                  highlightColor: utils.secondaryColor,
                                  child: Container(
                                    width: 180,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        VerifyInfoRow(
                          bottomBorder: true,
                          infoName: "Favorecido",
                          info: _controller.model.recipient?.name,
                        ),
                        VerifyInfoRow(
                          bottomBorder: true,
                          infoName: "Data do Pagamento",
                          info: _controller.model.settleDate,
                        ),
                        VerifyInfoRow(
                          bottomBorder: true,
                          infoName: "Desconto",
                          info: _controller.getValueMask(_controller
                              .model.discountPayment?.discountAmount),
                        ),
                        _controller.model.businessHour != null
                            ? VerifyInfoRow(
                                bottomBorder: true,
                                infoName: "Horário para pagamento",
                                info:
                                    "${_controller.model.businessHour?.start}h às ${_controller.model.businessHour?.end}h",
                              )
                            : Container(),
                        VerifyInfoRow(
                          bottomBorder: true,
                          jumpLine: true,
                          infoName: "Código de barras",
                          info: _controller.getBarCode(),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            'Até 2 dias úteis para ser processado.',
                            style: utils.textStyle.copyWith(
                              fontSize: 16,
                              color: utils.secondaryColor,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: utils.screenHeigthSize * 0.05,
                            ),
                            GenericButton(
                              text: "Avançar",
                              onPressedFunction: () => _controller
                                          .formKey.currentState
                                          ?.validate() ??
                                      false
                                  ? _controller.changePage()
                                  : DoNothingAction(),
                              color: utils.secondaryColor,
                              txtColor: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
