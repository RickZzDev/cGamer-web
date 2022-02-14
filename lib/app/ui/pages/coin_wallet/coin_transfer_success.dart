import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CoinTransferSuccess extends StatelessWidget {
  TransferReviewModel model;
  bool isWithdraw;
  CoinTransferSuccess({Key? key})
      : model = Get.arguments['transferReviewModel'],
        isWithdraw = Get.arguments['isWithdraw'],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: GenericButton(
          text: 'Voltar ao início',
          txtColor: Colors.white,
          color: primaryColor,
          onPressedFunction: () => Get.toNamed(
            Routes.MAIN_PAGES_HOLDER,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Text(
            isWithdraw
                ? 'Solicitação de retirada\nrealizada com sucesso!'
                : 'Transferência realizada\ncom sucesso!',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Center(
              child: Container(
            height: 200,
            child: Lottie.asset('assets/animations/success.json', repeat: true),
          )),
          SizedBox(
            height: 36,
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child:
                  Image.asset('assets/images/gamification_icons/mafa_coin.png'),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: 'Exo',
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: isWithdraw
                        ? "Você irá receber\n"
                        : "Você realizou\numa transferência de \n ",
                    style: textStyle.copyWith(
                        fontSize: 20, color: Colors.white70)),
                TextSpan(
                    text: "${model.quantity} ".replaceAll('.', ','),
                    style: textStyle.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: "\$",
                  style: textStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9900CC),
                  ),
                ),
                TextSpan(
                  text: "MAFA ",
                  style: textStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: isWithdraw ? '\nem sua carteira\n' : '\npara ',
                    style: textStyle.copyWith(
                        fontSize: 20, color: Colors.white70)),
                TextSpan(
                    text: isWithdraw
                        ? '${model.userDestination}'
                        : '@${model.userDestination} ',
                    style:
                        textStyle.copyWith(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
          isWithdraw
              ? Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Aguarde até 48h úteis \npara conferir sua carteira informada.',
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(
                      fontSize: 14,
                    ),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
