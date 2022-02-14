// import 'package:cGamer/app/ui/components/cash_in_components/info_confirm_row.dart';
import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/success_payment_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillPaymentSuccessPage extends StatefulWidget {
  @override
  _BillPaymentSuccessPageState createState() => _BillPaymentSuccessPageState();
}

class _BillPaymentSuccessPageState extends State<BillPaymentSuccessPage> {
  final BillPaymentSuccessController _controller =
      Get.find<BillPaymentSuccessController>();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.primaryColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 36, left: 36, right: 36, bottom: 24),
            height: utils.screenHeigthSize * 0.45,
            // color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Boleto pago",
                  style: utils.textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "com sucesso!",
                  style: utils.textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 110,
                  child: SvgPicture.asset(
                      "assets/images/deposit_way_icons/transfer_check.svg"),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Até 2 dias úteis para ser processado",
                  textAlign: TextAlign.center,
                  style: utils.textStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: utils.secondaryColor,
                borderRadius: utils.radiusTop15,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  CustomRichText(
                    customText: "${_controller.model.amountFormatted}",
                    normalText: "Você pagou",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  VerifyInfoRow(
                    infoName: "Favorecido",
                    info: _controller.model.recipient?.name,
                    color: Colors.white,
                    bottomBorder: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  VerifyInfoRow(
                    info: _controller.model.settleDate != null
                        ? _controller.model.settleDate
                        : DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    infoName: "Data do pagamento",
                    color: Colors.white,
                    bottomBorder: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                      child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: GenericButton(
                                text: "Ver comprovante",
                                txtColor: Colors.white,
                                onPressedFunction: () => Get.toNamed(
                                  Routes.PAYMENT_BILL_RECEIPT,
                                  arguments: {
                                    "bill_payment_model": _controller.model
                                  },
                                ),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          GenericButton(
                            text: "Voltar ao inicio",
                            color: Colors.grey[400]!,
                            onPressedFunction: () =>
                                Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                            txtColor: Colors.black54,
                          )
                        ]),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
