import 'package:cGamer/app/controllers/score/payment/payment_score_controller.dart';
import 'package:cGamer/app/controllers/score/trade_sucess/trade_sucess_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class TradeSucessPage extends StatelessWidget {
  final _controller = Get.put(TradeSucessController());

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(
            statusBarColor: primaryColor,
            systemNavigationBarColor: secondaryColor,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
            child: Container(
          height: screenHeigthSize,
          width: screenWidthhSize,
          child: Column(
            children: [
              Container(
                height: screenHeigthSize * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Troca realizada\ncom sucesso!',
                      style: textStyle.copyWith(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: screenHeigthSize * 0.18,
                      child: SvgPicture.asset(
                          'assets/images/deposit_way_icons/transfer_check.svg'),
                    ),
                    _controller.paymentType == PaymentType.CASHBACK
                        ? SizedBox(height: 0)
                        : Column(
                            children: [
                              _controller.hasCode
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _controller.tradeCode ?? "",
                                          style: textStyle.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.copy,
                                              color: primaryColor,
                                            ),
                                            onPressed: () {
                                              _controller.copyCodeToClipboard(
                                                  _controller.tradeCode ?? "");
                                            })
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 3),
                                      child: GenericButton(
                                          text: 'Resgatar',
                                          txtSize: 18,
                                          txtColor: secondaryColor,
                                          onPressedFunction: () =>
                                              _controller.launchUrl(_controller
                                                      .paymentGiftcardModel
                                                      ?.transaction
                                                      ?.url ??
                                                  "")),
                                    ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      right: 24, left: 24, bottom: 24),
                                  child: Text(
                                      'Instruções para resgate foram enviados \npara seu e-mail cadastrado.',
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center)),
                            ],
                          )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Row(
                        children: [
                          _controller.paymentType == PaymentType.CASHBACK
                              ? Image.asset(
                                  'assets/images/gamification_icons/cashback_icon.png',
                                  height: 50,
                                  width: 50,
                                  color: secondaryColor,
                                )
                              : Image.network(
                                  _controller.giftCardProduct?.iconUrl ?? "",
                                  height: 50,
                                  width: 50,
                                ),
                          VerticalDivider(
                            color: Colors.transparent,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _controller.paymentType == PaymentType.CASHBACK
                                  ? Text(
                                      "${_controller.cashbackProduct?.title}"
                                          .toString(),
                                      style: textStyle.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      _controller
                                              .giftCardProductDetails?.title ??
                                          "",
                                      style: textStyle.copyWith(
                                          fontSize: 15, color: Colors.black),
                                    ),
                              _controller.paymentType == PaymentType.CASHBACK
                                  ? Text(
                                      '${_controller.cashbackProduct?.points.formattedPoints()} Rubis',
                                      style: textStyle.copyWith(
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      '${_controller.giftCardProductDetails?.points.formattedPoints()} Rubis',
                                      style: textStyle.copyWith(
                                          color: Colors.black),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forma de pagamento',
                            style: textStyle,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/gamification_icons/cristal.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Rubis',
                                style: textStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data da troca',
                            style: textStyle,
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_rounded,
                                  color: secondaryColor),
                              SizedBox(width: 8),
                              Text(
                                _controller.getCurrentDate(),
                                style: textStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 16),
                      child: GenericButton(
                        text: 'Voltar ao início',
                        txtColor: Colors.white,
                        onPressedFunction: _controller.backToHome,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}
