import 'package:cGamer/app/controllers/coin_wallet/buy_coin_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/confirm_buy_coin_controller.dart';
import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner_slim.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/screen_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';

class ConfirmBuyCoin extends StatefulWidget {
  @override
  _ConfirmBuyCoinState createState() => _ConfirmBuyCoinState();
}

class _ConfirmBuyCoinState extends State<ConfirmBuyCoin> {
  final ConfirmBuyCoinController _controller =
      Get.find<ConfirmBuyCoinController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: PreferredSize(
              child: CustomAppBar(
                appBarTxt: 'Comprar \$\MAFA',
              ),
              preferredSize: Size.fromHeight(60),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              // Obx(() => _controller.isPrime.value
              //     ? Container()
              //     : ProBannerSlim(
              //         title: "Prime: 50% OFF na taxa de serviço de compra.")),
              Container(
                padding: EdgeInsets.only(right: 24, left: 24, top: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Formas de pagamento ', style: textStyle.copyWith()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(color: primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: SvgPicture.asset(
                                      'assets/images/home_images/pix.svg',
                                      color: secondaryColor)),
                              SizedBox(height: 8),
                              Text(
                                'Pix',
                                style: textStyle.copyWith(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 24),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      width: screenWidthhSize,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resumo da compra',
                            style: textStyle.copyWith(),
                          ),
                          SizedBox(height: 12),
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
                              ])
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
                  Obx(() => _controller.isPayPix.value
                      ? Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: screenWidthhSize,
                          height: 174,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Efetue o pagamento',
                                style: textStyle.copyWith(),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pix QRCode',
                                          style: textStyle.copyWith(
                                              fontSize: 14,
                                              color: Colors.white54)),
                                      SizedBox(height: 8),
                                      Container(
                                          color: Colors.white,
                                          child: SizedBox(
                                              height: 90,
                                              width: 90,
                                              child: Image.network(
                                                  '${_controller.model.value.pixImage}'))),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pix Copia e Cola',
                                          style: textStyle.copyWith(
                                              fontSize: 14,
                                              color: Colors.white54)),
                                      SizedBox(height: 8),
                                      GenericButton(
                                          text: 'Copiar código',
                                          onPressedFunction: () {
                                            _controller.copyPastePix();
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))
                      : Container())
                ]),
              ),
            ])),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 40),
              child: Obx(() => GenericButton(
                  text: _controller.isPayPix.value
                      ? 'Confirmar pagamento'
                      : 'Pagar com PIX',
                  onPressedFunction: () => {_controller.tapContinue()})),
            ),
          ),
        ),
      ),
    );
  }
}
