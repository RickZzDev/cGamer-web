import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';

class FromUserData extends StatelessWidget {
  final FromCustomer? fromCustomer;
  FromUserData({Key? key, required this.fromCustomer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerifyInfoRow(
          infoName: "De",
          info: "",
          bottomBorder: true,
        ),
        SizedBox(
          height: 12,
        ),
        VerifyInfoRow(
          infoName: "Nome ",
          info: fromCustomer?.customerName,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Agência",
                      style: utils.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: utils.secondaryColor),
                    ),
                    Text(
                      fromCustomer?.customerAccount?.agency ?? "",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Conta",
                      style: utils.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: utils.secondaryColor),
                    ),
                    Text(
                      fromCustomer?.customerAccount?.account ?? "",
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
        SizedBox(
          height: 12,
        ),
        VerifyInfoRow(
          infoName: "Banco",
          info:
              utf8.decode(fromCustomer?.customerAccount?.bank?.codeUnits ?? []),
          bottomBorder: true,
        ),
      ],
    );
  }
}
