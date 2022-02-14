import 'package:cGamer/app/controllers/cash_actions_controllers/receipt_controller/receipt_controller.dart';
import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class BillPaymentReceiptPage extends StatefulWidget {
  @override
  _BillPaymentReceiptPageState createState() => _BillPaymentReceiptPageState();
}

class _BillPaymentReceiptPageState extends State<BillPaymentReceiptPage> {
  final ReceiptController _controller = Get.find<ReceiptController>();
  String? value;
  BillPaymentConfirmResponseModel _responseModel =
      BillPaymentConfirmResponseModel();
  FromCustomer fromCustomer = FromCustomer();

  @override
  void initState() {
    _responseModel = Get.arguments["bill_payment_model"];
    fromCustomer.customerAccount = _responseModel.customerAccount;
    fromCustomer.customerName = _responseModel.nick;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Comprovante",
        ),
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: _controller.screenshotController,
          child: Container(
            decoration: BoxDecoration(
              color: utils.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 150,
                      margin: EdgeInsets.only(left: 32, top: 32),
                      child: Image.asset('assets/images/logo/logo_gray.png'),
                    ),
                    Obx(() {
                      return Opacity(
                        opacity: _controller.iconOnScreen.value ? 1 : 0,
                        child: IconButton(
                          onPressed: () => _controller.captureScreenshot(),
                          icon: Icon(Icons.ios_share),
                          color: utils.secondaryColor,
                          iconSize: 24,
                        ),
                      );
                    })
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        VerifyInfoRow(
                          infoName: "Pagador",
                          info: fromCustomer.customerNick != null
                              ? fromCustomer.customerNick
                              : "",
                          bottomBorder: true,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8, top: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: utils.secondaryColor),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: utils.screenWidthhSize * 0.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Agência",
                                      style: utils.textStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: utils.secondaryColor),
                                    ),
                                    Text(
                                      fromCustomer.customerAccount?.agency
                                              .toString() ??
                                          "",
                                      style: utils.textStyle.copyWith(
                                        color: utils.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: utils.screenWidthhSize * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Conta",
                                      style: utils.textStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: utils.secondaryColor),
                                    ),
                                    Text(
                                      fromCustomer.customerAccount?.account ??
                                          "",
                                      style: utils.textStyle.copyWith(
                                        color: utils.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Valor",
                            style: utils.textStyle.copyWith(
                              color: utils.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _responseModel.amountFormatted ?? "",
                            style: utils.textStyle.copyWith(
                                color: utils.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          )
                        ])),
                SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        VerifyInfoRow(
                          infoName: "Data do Pagamento",
                          info: _responseModel.settleDate != null
                              ? _responseModel.settleDate
                              : DateFormat('dd/MM/yyyy').format(DateTime.now()),
                          bottomBorder: true,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        _responseModel.recipient != null
                            ? VerifyInfoRow(
                                infoName: "Favorecido",
                                info: _responseModel.recipient?.name,
                                bottomBorder: true,
                              )
                            : Container(),
                        SizedBox(
                          height: 4,
                        ),
                        VerifyInfoRow(
                          bottomBorder: false,
                          noBorder: true,
                          jumpLine: true,
                          infoName: "Código de barras",
                          info: _responseModel.digitable,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: utils.secondaryColor,
                  height: 100,
                  width: utils.screenWidthhSize,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      Container(
                        width: utils.screenWidthhSize,
                        height: 25,
                        child: SvgPicture.asset(
                          "assets/images/picotado.svg",
                          color: utils.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Text("Autenticação:",
                          style: utils.textStyle
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(_responseModel.authenticationCode ?? "",
                          style: utils.textStyle)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
