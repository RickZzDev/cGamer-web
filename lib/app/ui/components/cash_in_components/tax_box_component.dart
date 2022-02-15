import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;

class TaxBox extends StatelessWidget {
  final String depositValue;
  final String taxValue;
  final String valueToReceive;
  final String txt;
  final String typeTransferTxt;
  TaxBox(
      {required this.depositValue,
      required this.taxValue,
      required this.valueToReceive,
      required this.txt,
      this.typeTransferTxt = "Depósito"});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 105,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Resumo da solicitação",
            style: themes.textStyle.copyWith(
              color: themes.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                typeTransferTxt,
                style: themes.textStyle.copyWith(
                  color: themes.secondaryColor,
                  fontSize: 16,
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 100),
                // width: ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "R\$",
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                      ),
                    ),
                    Text(
                      depositValue.split("\$")[1],
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarifa",
                style: themes.textStyle.copyWith(
                  color: themes.secondaryColor,
                  fontSize: 16,
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "R\$",
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                      ),
                    ),
                    Text(
                      taxValue.split("\$")[1],
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            color: Colors.white,
            height: 1,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                txt,
                style: themes.textStyle.copyWith(
                  color: themes.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "R\$",
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      valueToReceive.split("\$")[1],
                      style: themes.textStyle.copyWith(
                        color: themes.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
