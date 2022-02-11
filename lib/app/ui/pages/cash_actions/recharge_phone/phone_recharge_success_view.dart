// import 'package:cGamer/app/ui/components/cash_in_components/info_confirm_row.dart';
import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_success_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhoneRechargeSuccessView extends StatelessWidget {
  final PhoneRechargeSuccessController _controller =
      Get.find<PhoneRechargeSuccessController>();

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
                  "Recarga em",
                  style: utils.textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "andamento!",
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
                  "Aguarde... sua recarga será processada em alguns instantes.",
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
                  Text("Você recarregou ${_controller.model.valueFormatted}.",
                      textAlign: TextAlign.center,
                      style: utils.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  VerifyInfoRow(
                    infoName: "Número do telefone",
                    info: _controller.model.phone,
                    color: Colors.white,
                    bottomBorder: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  VerifyInfoRow(
                    info: _controller.model.rechargeDate,
                    infoName: "Data da recarga",
                    color: Colors.white,
                    bottomBorder: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  VerifyInfoRow(
                    infoName: "Operadora",
                    info: _controller.model.provider?.name,
                    color: Colors.white,
                    bottomBorder: true,
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
                            text: "Voltar ao inicio",
                            color: Colors.grey[400],
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
