import 'package:cGamer/app/controllers/wallet_controllers/wallet_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BodyAtivactedVirtualCard extends StatelessWidget {
  const BodyAtivactedVirtualCard({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidthhSize,
        child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenericButton(
                    icon: Icons.credit_card,
                    height: 48,
                    txtColor: secondaryColor,
                    text: 'Ativar cartão virtual',
                    onPressedFunction: () {
                      if (controller.verifyDocumentsSend()) {
                        Get.toNamed(Routes.WALLET_ADD_VIRTUAL_CARD_NAME_STEP);
                      } else {
                        SnackBarUtils.showSnackBar(
                          icon: Icon(
                            Icons.error_outline,
                            color: Colors.white,
                          ),
                          desc:
                              "Para acessar é necessário ativar sua conta.",
                          title: "Atenção",
                          color: Colors.orange[400],
                        );
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  SvgPicture.asset(
                    'assets/images/marketplace/Assinatura.svg',
                    color: primaryColor,
                    fit: BoxFit.fitWidth,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Use na função crédito',
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Você passa seu cartão na função crédito e o valor é descontado na mesma hora de sua conta.',
                          style: textStyle.copyWith(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ]))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  SvgPicture.asset(
                    'assets/images/wallet_images/Sem_Parcelas.svg',
                    color: primaryColor,
                    fit: BoxFit.cover,
                    height: 22,
                    width: 22,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Sem parcelas e faturas',
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Seu cartão utiliza o saldo da sua conta, descontando o valor no momento da compra. Por isso não é possível fazer parcelamentos.',
                          style: textStyle.copyWith(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ]))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  SvgPicture.asset(
                    'assets/images/wallet_images/Compras_Internacionais.svg',
                    color: primaryColor,
                    fit: BoxFit.cover,
                    height: 28,
                    width: 28,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Compras internacionais',
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'É possível realizar compras online no Brasil e no exterior.',
                          style: textStyle.copyWith(
                              fontSize: 14, color: Colors.white70),
                        ),
                      ]))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  SvgPicture.asset(
                    'assets/images/home_images/Recarga_de_celular.svg',
                    color: primaryColor,
                    fit: BoxFit.scaleDown,
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Aplicativos',
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Você também pode utilizar seu cartão virtual Gamer para aplicativos de entrega, alimentação e transporte. Que tal? :)',
                          style: textStyle.copyWith(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ]))
                ]),
                SizedBox(height: 16),
                Row(children: [
                  SvgPicture.asset(
                    'assets/images/marketplace/Streaming.svg',
                    color: primaryColor,
                    fit: BoxFit.scaleDown,
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Assinaturas online',
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Aproveite seu cartão para assinaturas de músicas, filmes e jogos online.',
                          style: textStyle.copyWith(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ]))
                ]),
              ],
            )));
  }
}
