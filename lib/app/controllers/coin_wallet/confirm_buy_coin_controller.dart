import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class ConfirmBuyCoinController extends GetxController {
  final CoinWalletRepository repository;
  ConfirmBuyCoinController({required this.repository});

  var loading = false.obs;
  var isPayPix = false.obs;
  double totalCoins = 0;
  double totalValue = 0;
  MoneyMaskedTextController moneyController = MoneyMaskedTextController();
  MoneyMaskedTextController taxController = MoneyMaskedTextController();
  MoneyMaskedTextController totalController = MoneyMaskedTextController();
  MoneyMaskedTextController coinController = MoneyMaskedTextController();
  var messageError = "".obs;
  Rx<PayWithPixModel> model = PayWithPixModel().obs;
  double taxValue = 0.02;
  var isPrime = false.obs;

  @override
  void onInit() async {
    totalCoins = Get.arguments['totalCoins'];
    totalValue = Get.arguments['totalValue'];
    moneyController = MoneyMaskedTextController(
      initialValue: totalValue,
    );
    coinController = MoneyMaskedTextController(
      initialValue: totalCoins,
    );
    double tax = totalValue * taxValue;
    taxController = MoneyMaskedTextController(
      initialValue: tax,
    );
    totalController = MoneyMaskedTextController(
      initialValue: totalValue + tax,
    );

    super.onInit();
  }

  void tapContinue() async {
    if (isPayPix.value) {
      //finalizar fluxo.
      //chamar servico para confirmar

      loading.value = true;
      var authorizationCode = model.value.orderId;

      try {
        var response = await repository.confirmPix(authorizationCode);
        loading.value = false;
        if (ExceptionUtils.verifyIfIsException(response)) {
          SnackBarUtils.showSnackBar(
              desc: "Ocorreu um erro, tente novamente mais tarde!",
              title: 'Atenção');
          return;
        }

        if (response.status) {
          DartNotificationCenter.post(channel: 'refreshMafaWalletPage');
          Get.toNamed(Routes.WALLET_SUCCESS_BUY_COIN, arguments: {
            'totalValue': totalValue,
            'totalCoins': totalCoins,
            'authorizationCode': authorizationCode
          });
        } else {
          SnackBarUtils.showSnackBar(
              desc:
                  'Aguardando processamento do pagamento, tente novamente em alguns instantes..',
              title: 'Atenção',
              color: Colors.orange[400]);
        }

        return;
      } catch (e) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Algo de errado aconteceu, tente novamente em alguns instantes...",
            title: "Atenção");
        return;
      }
    } else {
      //chamar servico pix
      showModalResponsability();
    }
  }

  void showModalResponsability() {
    showModalBottomSheet(
        backgroundColor: secondaryColor,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          return Builder(
              builder: (context) => Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  width: screenWidthhSize,
                  height: 430,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text('Isenção de Responsabilidade',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          'O Jogga Bank somente é responsável por facilitar a compra do Token \$\MAFA. Realizamos somente a intermediação da compra.  \n\nVocê concorda, que está a realizar uma transação por sua própria conta, tendo feito a sua própria pesquisa. Caso desconheça sobre esse assunto, aconselhamos procurar por mais informações ou abstenha-se de realizar a transação. \n\nAviso Legal: O Jogga Bank e o Mafagafo não fornece nenhuma garantia de rentabilidade, todas as informações da página são pautadas em estimativas sem nenhuma garantia de retorno. Dito isso, não nos responsabilizamos por eventuais perdas ou prejuízos.',
                          style: textStyle.copyWith(fontSize: 14),
                          textAlign: TextAlign.justify),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
                              child: GenericButton(
                                  text: 'Não concordo',
                                  color: Colors.white70,
                                  onPressedFunction: () {
                                    Get.back();
                                  })),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                              width: 150,
                              child: GenericButton(
                                  text: 'Eu concordo',
                                  color: primaryColor,
                                  onPressedFunction: () {
                                    payPix();
                                    Get.back();
                                  })),
                        ],
                      )
                    ],
                  )));
        });
  }

  Future<void> payPix() async {
    loading.value = true;
    PayWithPixRequest request = PayWithPixRequest();
    request.amount = totalValue + (totalValue * taxValue);
    try {
      var response = await repository.payWithPix(request);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Ocorreu um erro, tente novamente mais tarde!",
            title: 'Ops..');
        return;
      }
      // valueCoin.value = response.currentCoinValue;
      model.value = response;

      isPayPix.value = true;
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao gerar a cobrança, tente novamente mais tarde!",
          title: "Ops...");
      return;
    }
  }

  void copyPastePix() {
    FlutterClipboard.copy('${model.value.pixCopyPaste}')
        .then((value) => Get.rawSnackbar(
              message: "Código copiado com sucesso",
              backgroundColor: primaryColor,
            ));
  }
}
