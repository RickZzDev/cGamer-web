import 'package:cGamer/app/controllers/coin_wallet/buy_coin_controller.dart';
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

class BuyCoinView extends StatefulWidget {
  @override
  _BuyCoinViewState createState() => _BuyCoinViewState();
}

class _BuyCoinViewState extends State<BuyCoinView> {
  final BuyCoinController _controller = Get.find<BuyCoinController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.only(right: 24, left: 24, top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Quantos ', style: textStyle.copyWith()),
                      Text('\$',
                          style: textStyle.copyWith(color: Color(0xFF9900CC))),
                      Text('MAFA Coins ', style: textStyle.copyWith()),
                      Text('deseja comprar? ', style: textStyle.copyWith()),
                    ],
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 24),
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                  'assets/images/gamification_icons/mafa_coin.png')))),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 36,
                                width: 36,
                                child: Image.asset(
                                    'assets/images/gamification_icons/mafa_coin.png')),
                            SizedBox(width: 4),
                            Text('\$',
                                style: textStyle.copyWith(
                                    color: Color(0xFF9900CC))),
                            Text('MAFA ', style: textStyle.copyWith()),
                          ],
                        ),
                        Container(
                            height: 50,
                            width: 200,
                            child: TextField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                autofocus: false,
                                minLines: 1,
                                onChanged: (value) =>
                                    _controller.calculateGGCToBRL(value),
                                controller: _controller.coinController,
                                style: textStyle.copyWith(fontSize: 22),
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle:
                                        textStyle.copyWith(fontSize: 22)))),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                    'assets/images/gamification_icons/icon_trade_coin.png'))),
                        SizedBox(width: 8),
                        Text('Cotação atual de 1 ',
                            style: textStyle.copyWith(fontSize: 14)),
                        Text('\$',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Color(0xFF9900CC))),
                        Text('MAFA', style: textStyle.copyWith(fontSize: 14)),
                        Text(' é de ', style: textStyle.copyWith(fontSize: 14)),
                        Obx(
                          () => Text(
                            _controller.model.value.currentCoinValueFormatted !=
                                        '' &&
                                    _controller.model.value.currentCoinValue !=
                                        -1
                                ? _controller
                                    .model.value.currentCoinValueFormatted
                                : '---',
                            style: textStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: primaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                    'assets/images/gamification_icons/icon_brl.png')),
                            SizedBox(width: 8),
                            Text('R\$',
                                style: textStyle.copyWith(color: primaryColor)),
                            Text('BRL', style: textStyle.copyWith()),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            autofocus: false,
                            minLines: 1,
                            controller: _controller.moneyController,
                            onChanged: (value) =>
                                _controller.calculateBRLToGGC(),
                            style: textStyle.copyWith(fontSize: 22),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.,]')),
                            ],
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: textStyle.copyWith(fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Valor mínimo de compra R\$ 50,00',
                          style: textStyle.copyWith(
                              fontSize: 13,
                              color: _controller.messageError.value != ""
                                  ? Colors.red
                                  : Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    width: screenWidthhSize,
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Obx(
                            () => Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: _controller.checkBoxValue.value,
                              onChanged: (_value) =>
                                  _controller.setCheckBox(_value),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                        Container(
                            width: screenWidthhSize - 88,
                            child: Text(
                              'Eu entendo o risco associado a esta compra, e que uma vez confirmada, a minha compra é definitiva e não pode ser cancelada.',
                              style: textStyle.copyWith(
                                  fontSize: 13, color: Colors.white),
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: 45, vertical: Platform.isIOS ? 40 : 0),
        //   child: GenericButton(
        //     enabled: _controller.checkBoxValue.value,
        //     text: 'Próximo',
        //     onPressedFunction: () => {
        //       if (_controller.checkBoxValue.value) {_controller.tapContinue()}
        //     },
        //   ),
        // ),
      ),
    );
  }
}
