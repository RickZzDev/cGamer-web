import 'package:cGamer/app/controllers/coin_wallet/withdraw_coin_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner_slim.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WithdrawCoinView extends StatefulWidget {
  @override
  _WithdrawCoinViewState createState() => _WithdrawCoinViewState();
}

class _WithdrawCoinViewState extends State<WithdrawCoinView> {
  final WithdrawCoinController _controller = Get.find<WithdrawCoinController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ModalProgressHUD(
            inAsyncCall: _controller.loading.value,
            child: Scaffold(
                backgroundColor: secondaryColor,
                appBar: CustomAppBar(
                  appBarTxt: 'Retirar \$MAFA',
                ),
                bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: GenericButton(
                    text: 'Próximo',
                    enabled: !_controller.shouldShowError.value &&
                        _controller.walletIdController.text != "",
                    txtColor: Colors.white,
                    color: primaryColor,
                    onPressedFunction: () {
                      if (!_controller.shouldShowError.value &&
                          _controller.walletIdController.text != "") {
                        double totalWithdrawMafa = double.parse(_controller
                            .mafaQuantityController.text
                            .replaceAll(',', '.'));

                        if (totalWithdrawMafa < 500) {
                          SnackBarUtils.showSnackBar(
                              color: Colors.orange[400],
                              desc:
                                  'O valor mínimo para solicitar retirada é de 500 \$\MAFA',
                              title: 'Ops...');
                        } else {
                          _controller.tapContinue();
                        }
                      }
                    },
                  ),
                ),
                body: Column(children: [
                  Obx(() => _controller.isPrime.value
                      ? Container()
                      : ProBannerSlim(
                          title: "Prime: Zere a taxa de serviço na retirada.")),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Exo',
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Quantos ",
                              ),
                              TextSpan(
                                text: "\$",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9900CC),
                                ),
                              ),
                              TextSpan(text: 'MAFA você deseja retirar?'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              'Saldo disponível: ',
                              style: textStyle,
                            ),
                            SizedBox(
                              height: 15,
                              width: 15,
                              child: Image.asset(
                                'assets/images/gamification_icons/mafa_coin.png',
                              ),
                            ),
                            Text(
                              ' ${_controller.mafaAmmount} '
                                  .replaceAll('.', ','),
                              style: textStyle,
                            ),
                            Text(
                              '\$',
                              style: textStyle.copyWith(
                                color: Color(0xFF9900CC),
                              ),
                            ),
                            Text(
                              'MAFA',
                              style: textStyle,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Valor mínimo para saque é de 500 \$\MAFA',
                            style: textStyle.copyWith(fontSize: 13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: primaryColor)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 36,
                                        width: 36,
                                        child: Image.asset(
                                          'assets/images/gamification_icons/mafa_coin.png',
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        ' \$',
                                        style: textStyle.copyWith(
                                          color: Color(0xFF9900CC),
                                        ),
                                      ),
                                      Text(
                                        'MAFA ',
                                        style: textStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    child: TextField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      autofocus: true,
                                      minLines: 1,
                                      style: textStyle.copyWith(fontSize: 22),
                                      textAlign: TextAlign.right,
                                      controller:
                                          _controller.mafaQuantityController,
                                      onChanged: (_) =>
                                          _controller.verifyIfHavaAmmount(
                                        inputedAmmount: _controller
                                                .mafaQuantityController
                                                .text
                                                .isEmpty
                                            ? 0
                                            : double.parse(_controller
                                                .mafaQuantityController.text
                                                .replaceAll('.', '')
                                                .replaceAll(',', '.')),
                                        availableAmmount:
                                            _controller.mafaAmmount,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "0",
                                        hintStyle: textStyle.copyWith(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text(
                                      '+ Taxa de serviço: ${_controller.taxValue.value == "" ? "---" : "${_controller.taxValue.value}"}',
                                      style: textStyle.copyWith(fontSize: 14)),
                                  Text(' \$',
                                      style: textStyle.copyWith(
                                          fontSize: 14,
                                          color: Color(0xFF9900CC))),
                                  Text('MAFA',
                                      style: textStyle.copyWith(fontSize: 14))
                                ]),
                                SizedBox(
                                  child: Text(
                                    _controller.shouldShowError.value
                                        ? 'Saldo insuficiente'
                                        : '',
                                    style: textStyle.copyWith(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Informe abaixo o ID da sua carteira (0x...) ',
                          style: textStyle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: _controller.walletIdController,
                          labelText: 'ID da carteira (0x...)',
                        ),
                      ],
                    ),
                  ),
                ])),
          ),
        ));
  }
}
