import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';

class ConfirmValue extends StatefulWidget {
  @override
  _ConfirmValueState createState() => _ConfirmValueState();
}

class _ConfirmValueState extends State<ConfirmValue> {
  String? value;

  TedInfoModel _tedInfoModel = TedInfoModel();
  bool contactSaved = false;

  @override
  void initState() {
    value = Get.arguments["value"] != null
        ? Get.arguments["value"]
        : DoNothingAction();

    contactSaved = Get.arguments['contact_saved'] != null &&
            Get.arguments['contact_saved'] == true
        ? true
        : false;
    _tedInfoModel = Get.arguments["ted_info"] != null
        ? Get.arguments["ted_info"]
        : DoNothingAction();

    super.initState();
  }

  TextEditingController messageController = TextEditingController();

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
        child: Container(
          height: utils.screenHeigthSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: CustomRichText(
                  normalText: "",
                  textAlign: TextAlign.start,
                  customText: "Confirme os dados abaixo para a  transferência",
                  customFirst: true,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: utils.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
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
                          value ?? "",
                          style: utils.textStyle.copyWith(
                              color: utils.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        VerifyInfoRow(
                          infoName: "Nome",
                          info: _tedInfoModel.fullName != null
                              ? "${utf8.decode(_tedInfoModel.fullName!.codeUnits)}"
                              : "",
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        VerifyInfoRow(
                          infoName: "CPF",
                          info: "${_tedInfoModel.cpf}",
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        VerifyInfoRow(
                          infoName: "Banco",
                          info: "${_tedInfoModel.bank}",
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        VerifyInfoRow(
                          infoName: "Método",
                          info: "${_tedInfoModel.method}",
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        VerifyInfoRow(
                          infoName: "Data de transferência",
                          info: "${_tedInfoModel.transferDate}",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 40,
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GenericButton(
                                text: "Avançar",
                                haveToReturnContext: false,
                                onPressedFunction: () {
                                  _tedInfoModel.description =
                                      messageController.text;
                                  Get.toNamed(
                                    Routes.TRANSFER_CONFIRM_PASSWORD,
                                    arguments: {
                                      'value': value,
                                      'ted_info': _tedInfoModel,
                                      "contact_saved": contactSaved
                                    },
                                  );
                                },
                                color: utils.secondaryColor,
                                txtColor: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
