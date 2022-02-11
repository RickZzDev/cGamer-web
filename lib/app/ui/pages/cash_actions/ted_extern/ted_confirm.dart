import 'dart:convert';

import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/money_text_mask_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:intl/intl.dart';

class TedConfirmView extends StatefulWidget {
  @override
  _TedConfirmViewState createState() => _TedConfirmViewState();
}

class _TedConfirmViewState extends State<TedConfirmView> {
  TedInfoModel tedInfo = TedInfoModel();
  TextEditingController messageController = TextEditingController();
  MaskedTextController cpfWithMask =
      MaskedTextController(mask: '000.000.000-00');
  final moneyController = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  );

  @override
  void initState() {
    tedInfo = Get.arguments["ted_info"];
    tedInfo.method = "TED";
    tedInfo.transferDate = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );
    cpfWithMask.text = tedInfo.cpf;
    moneyController.text = tedInfo.ammount ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Transferir",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: CustomRichText(
                textAlign: TextAlign.start,
                customFirst: true,
                customText: "Confirme os dados",
                normalText: "abaixo para a transferência",
                // customFirst: true,
              ),
            ),
            Container(
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
                      "Valor a ser transferido",
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      moneyController.text,
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "valor a ser debitado: ${tedInfo.ammountWithTax} *",
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "valor a ser transferido + taxa de retirada",
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Para",
                      info: "",
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Nome completo",
                      info: tedInfo.fullName,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "CPF",
                      info: cpfWithMask.text,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Banco",
                      info: tedInfo.bank,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Agência",
                      info: tedInfo.agency,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Conta",
                      info: tedInfo.accountNumber,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Tipo de conta",
                      info: tedInfo.accounType == "SAVINGS"
                          ? "Conta Poupança"
                          : "Conta Corrente",
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Método",
                      info: tedInfo.method,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Data da transferência",
                      info: tedInfo.transferDate,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Taxa de retirada",
                      info: "${tedInfo.transferTax}",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 24),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Escreva uma mensagem (opcional)",
                          contentPadding: const EdgeInsets.only(
                            left: 24.0,
                            bottom: 10.0,
                            // top: 8.0,
                          ),
                          hintStyle: utils.textStyle.copyWith(
                            color: utils.secondaryColor,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    GenericButton(
                      text: "Avançar",
                      onPressedFunction: () {
                        tedInfo.description = messageController.text;
                        Get.toNamed(Routes.TRANSFER_TED_EXTERN_PASSWORD,
                            arguments: {
                              'value': tedInfo.ammount,
                              "type": "transfer_extern",
                              "ted_info": tedInfo
                            });
                      },
                      color: utils.secondaryColor,
                      txtColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
