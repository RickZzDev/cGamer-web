import 'package:cGamer/app/controllers/coin_wallet/buy_coin_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/confirm_buy_coin_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/success_buy_coin_controller.dart';
import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/screen_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';

class SuccessBuyCoin extends StatefulWidget {
  @override
  _SuccessBuyCoinState createState() => _SuccessBuyCoinState();
}

class _SuccessBuyCoinState extends State<SuccessBuyCoin> {
  final SuccessBuyCoinController _controller =
      Get.find<SuccessBuyCoinController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                child: CustomAppBar(
                  actions: null,
                  removeIcon: true,
                  appBarTxt: 'Sucesso!',
                ),
                preferredSize: Size.fromHeight(60),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(right: 24, left: 24, top: 40),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Text(
                      'Parabéns!',
                      style: textStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Você comprou ${_controller.coinController.text} \$\MAFA!',
                      style: textStyle.copyWith(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          child: Lottie.asset('assets/animations/success.json',
                              repeat: true),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 36),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        width: screenWidthhSize,
                        height: 175,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dados da compra',
                              style: textStyle.copyWith(),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Identificador ',
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.white54)),
                                Row(children: [
                                  Text('${_controller.authorizationCode}',
                                      style: textStyle.copyWith(
                                        fontSize: 12,
                                      ))
                                ])
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantidade ',
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.white54)),
                                Row(children: [
                                  Text('\$\MAFA ',
                                      style: textStyle.copyWith(
                                          fontSize: 16, color: Colors.white60)),
                                  Text('${_controller.coinController.text}',
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                      ))
                                ])
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Valor ',
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.white54)),
                                Row(children: [
                                  Text('R\$ ',
                                      style: textStyle.copyWith(
                                          fontSize: 16, color: Colors.white60)),
                                  Text('${_controller.moneyController.text}',
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                      ))
                                ]),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Taxa de Serviço',
                                    style: textStyle.copyWith(
                                        fontSize: 14, color: Colors.white54)),
                                Row(children: [
                                  Text('R\$ ',
                                      style: textStyle.copyWith(
                                          fontSize: 16, color: Colors.white60)),
                                  Text('${_controller.taxController.text}',
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                      ))
                                ])
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Valor Total',
                                    style: textStyle.copyWith(
                                        fontSize: 18,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold)),
                                Row(children: [
                                  Text('R\$ ',
                                      style: textStyle.copyWith(
                                          fontSize: 18, color: Colors.white60)),
                                  Text('${_controller.totalController.text}',
                                      style: textStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ])
                              ],
                            )
                          ],
                        )),
                  ]),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 45, vertical: Platform.isIOS ? 40 : 0),
                child: GenericButton(
                    text: 'Voltar ao ínicio',
                    onPressedFunction: () => {_controller.tapFinish()}),
              )),
        )));
  }
}
