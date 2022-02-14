import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as style;
import 'package:flutter_svg/flutter_svg.dart';

import '../components.dart';

class ExtractDetailsModal extends StatelessWidget {
  final TransactionExtract? transactionExtract;
  final Details? details;

  ExtractDetailsModal({required this.transactionExtract, this.details});
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          details?.fromCustomer == null ? null : style.screenHeigthSize * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: style.primaryColor),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DetailsModalHeader(transactionExtract),
                    SizedBox(
                      height: 12,
                    ),
                    details?.fromCustomer != null //isTransfer
                        ? DetailsTransfer(
                            details: details,
                            transactionExtract: transactionExtract,
                          )
                        : DetailsPayment(
                            details: details,
                            transactionExtract: transactionExtract,
                          ),
                    SizedBox(
                      height: 12,
                    ),
                    transactionExtract?.details?.transactionId != null
                        ? Container(
                            color: style.secondaryColor,
                            height: 100,
                            width: style.screenWidthhSize,
                            padding: EdgeInsets.only(bottom: 8),
                            child: Column(
                              children: [
                                Container(
                                  width: style.screenWidthhSize,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    "assets/images/picotado.svg",
                                    color: style.primaryColor,
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Text("Autorização:",
                                    style: style.textStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(
                                    details?.transactionId ??
                                        transactionExtract?.id ??
                                        "",
                                    style: style.textStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: style.secondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}

class DetailsModalHeader extends StatelessWidget {
  final TransactionExtract? transactionExtract;

  DetailsModalHeader(this.transactionExtract);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 32, top: 32),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo/logo_gray.png',
              height: 80,
              width: 150,
            ),
            Text(
              transactionExtract?.date ?? "",
              style: style.textStyle.copyWith(color: style.secondaryColor),
            )
          ],
        ));
  }
}

class DetailsTransfer extends StatelessWidget {
  final Details? details;
  final TransactionExtract? transactionExtract;

  DetailsTransfer({this.details, this.transactionExtract});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          VerifyInfoRow(
            infoName: 'De',
            info: '',
            bottomBorder: true,
          ),
          VerifyInfoRow(
            infoName: 'Nome',
            info: details?.fromCustomer?.name ?? "",
            bottomBorder: true,
          ),
          details?.fromCustomer?.document != null
              ? VerifyInfoRow(
                  infoName: 'CPF',
                  info: details?.fromCustomer?.document,
                  bottomBorder: true,
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Agência",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.fromCustomer?.agency ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Conta",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.fromCustomer?.account ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
          details?.fromCustomer?.bankName == null
              ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: style.secondaryColor))),
                )
              : SizedBox(),
          details?.fromCustomer?.bankName != null
              ? VerifyInfoRow(
                  infoName: 'Banco',
                  info: details?.fromCustomer?.bankName,
                )
              : SizedBox(),
          details?.fromCustomer?.bankName != null
              ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: style.secondaryColor))),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.only(top: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valor",
                      textAlign: TextAlign.start,
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${transactionExtract?.amount}",
                      textAlign: TextAlign.start,
                      style: style.textStyle.copyWith(
                          fontSize: 40,
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "para ${details?.destination?.name}",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                ),
                Expanded(
                  child: SvgPicture.network(
                    transactionExtract?.iconUrl ?? "",
                    width: 50,
                    height: 50,
                    color: style.secondaryColor,
                  ),
                )
              ],
            ),
          ),
          VerifyInfoRow(
            infoName: 'Nome ',
            info: details?.destination?.name,
            bottomBorder: true,
          ),
          VerifyInfoRow(
            infoName: 'CPF',
            info: details?.destination?.document,
            bottomBorder: true,
          ),
          VerifyInfoRow(
            infoName: 'Banco',
            info: details?.destination?.bankName,
            bottomBorder: true,
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Agência",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.destination?.agency ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Conta",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.destination?.account ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPayment extends StatelessWidget {
  final Details? details;
  final TransactionExtract? transactionExtract;

  DetailsPayment({required this.details, required this.transactionExtract});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerifyInfoRow(
            infoName: 'Pagador',
            info: details?.payer ?? "",
            bottomBorder: true,
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: style.secondaryColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Agência",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.agency ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Conta",
                      style: style.textStyle.copyWith(
                          color: style.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(),
                    Text(
                      details?.account ?? "",
                      style:
                          style.textStyle.copyWith(color: style.secondaryColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          VerifyInfoRow(
            infoName: 'Digitalizável',
            info: details?.destination?.digitable,
            jumpLine: true,
            bottomBorder: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Valor",
                  textAlign: TextAlign.start,
                  style: style.textStyle.copyWith(
                      color: style.secondaryColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${transactionExtract?.amount}",
                  textAlign: TextAlign.start,
                  style: style.textStyle.copyWith(
                      fontSize: 40,
                      color: style.secondaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          VerifyInfoRow(
            infoName: 'Para',
            info: details?.destination?.name,
            bottomBorder: true,
          )
        ],
      ),
    );
  }
}
