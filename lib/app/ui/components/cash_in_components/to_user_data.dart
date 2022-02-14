import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ToUserData extends StatefulWidget {
  final ToCustomer? toCustomer;
  final String? bank;
  final String? method;
  final String? agency;
  final String? account;
  ToUserData(
      {Key? key,
      this.toCustomer,
      this.bank,
      this.method,
      this.agency,
      this.account})
      : super(key: key);

  @override
  _ToUserDataState createState() => _ToUserDataState();
}

class _ToUserDataState extends State<ToUserData> {
  MaskedTextController cpfMask = MaskedTextController(mask: '000.000.000-00');
  @override
  void initState() {
    cpfMask.text = widget.toCustomer?.costumerDocument;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerifyInfoRow(
          infoName: "Nome Completo",
          info: widget.toCustomer!.customerName,
          bottomBorder: true,
        ),
        SizedBox(
          height: 12,
        ),
        VerifyInfoRow(
          infoName: "CPF",
          info: cpfMask.text,
          bottomBorder: true,
        ),
        SizedBox(
          height: 12,
        ),
        widget.account != null && widget.agency != null
            ? Column(children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: secondaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidthhSize * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Agência",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            Text(
                              widget.agency ?? "0001",
                              style: textStyle.copyWith(
                                color: secondaryColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidthhSize * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Conta",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            Text(
                              widget.account!,
                              style: textStyle.copyWith(
                                color: secondaryColor,
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
                )
              ])
            : Container(),
        VerifyInfoRow(
          infoName: "Banco",
          info: widget.bank ?? "Acesso Soluções de Pagamentos S.A",
          bottomBorder: true,
        ),
        SizedBox(
          height: 12,
        ),
        VerifyInfoRow(
          infoName: "Método",
          info: widget.method ?? "Transferência entre gamers",
          bottomBorder: true,
        ),
        SizedBox(
          height: 12,
        ),
        VerifyInfoRow(
          infoName: "Data da transferência",
          info: DateFormat('dd/MM/yyy').format(DateTime.now()),
          noBorder: true,
          // bottomBorder: true,
        ),
        // SizedBox(
        // height: 12,
        // ),
        // VerifyInfoRow(
        //   infoName: "Autenticação",
        //   info: "xxxxxxxxxx",
        //   bottomBorder: true,
        // ),
      ],
    );
  }
}
