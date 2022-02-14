import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_confirm_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class PhoneRechargeConfirmView extends StatefulWidget {
  @override
  _PhoneRechargeConfirmViewState createState() =>
      _PhoneRechargeConfirmViewState();
}

class _PhoneRechargeConfirmViewState extends State<PhoneRechargeConfirmView> {
  final PhoneRechargeConfirmController _controller =
      Get.find<PhoneRechargeConfirmController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Recarga de celular",
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
                customText: "Confirma os dados",
                normalText: "abaixo para a recarga",
                // customFirst: true,
              ),
            ),
            Container(
              height: utils.screenHeigthSize - 170,
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
                      "Valor a ser recarregado",
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _controller.model.valueFormatted ?? "",
                      style: utils.textStyle.copyWith(
                        color: utils.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Para",
                      info: _controller.model.nick,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Número do telefone",
                      info: _controller.model.phone,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Operadora",
                      info: _controller.model.provider?.name,
                    ),
                    VerifyInfoRow(
                      bottomBorder: true,
                      infoName: "Data de recarga",
                      info: _controller.model.rechargeDate,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            GenericButton(
                              text: "Avançar",
                              onPressedFunction: () => _controller.changePage(),
                              color: utils.secondaryColor,
                              txtColor: Colors.white,
                            )
                          ],
                        ),
                      ),
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
