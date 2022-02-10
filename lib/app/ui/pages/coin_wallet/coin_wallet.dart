import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CoinWallet extends StatefulWidget {
  @override
  State<CoinWallet> createState() => _CoinWalletState();
}

class _CoinWalletState extends State<CoinWallet> {
  final CoinWalletController _controller = Get.put(
    CoinWalletController(
      repository: CoinWalletRepository(
          provider: CoinWalletProvider(requester: Requester())),
    ),
  );

  @override
  void initState() {
    _controller.getLastMoviments();
    _controller.getMafaBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(secondaryColor);

    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: !_controller.currentBalanceFinished.value ||
            !_controller.mafaExtractFinished.value,
        child: RefreshIndicator(
          onRefresh: () => _controller.refresh(),
          child: Scaffold(
            backgroundColor: secondaryColor,
            body: Container(
              decoration: BoxDecoration(color: secondaryColor),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 48),
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: Image.asset(
                            'assets/images/gamification_icons/mafa_coin.png',
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                  _controller
                                      .currentMafaBalance.value.balanceAvailable
                                      .toStringAsFixed(2)
                                      .replaceAll('.', ','),
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '\$',
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(
                                fontSize: 24,
                                color: Color(0xFF9900CC),
                              ),
                            ),
                            Text('MAFA',
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(fontSize: 24)),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                  '${_controller.currentMafaBalance.value.totalBalance}',
                                  textAlign: TextAlign.center,
                                  style: textStyle.copyWith(
                                      fontSize: 18, color: Colors.white70)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.WALLET_BUY_COIN,
                                        );
                                      },
                                      child: Container(
                                        width: screenWidthhSize / 5,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                                color: primaryColor)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              child: SvgPicture.asset(
                                                'assets/images/wallet_images/buy_coin.svg',
                                                color: primaryColor,
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text('Comprar',
                                                style: textStyle.copyWith(
                                                    fontSize: 12))
                                          ],
                                        ),
                                      )),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => Get.toNamed(
                                        Routes.WALLET_COIN_TRANSFER,
                                        arguments: {
                                          'mafaAmmount': _controller
                                              .currentMafaBalance
                                              .value
                                              .balanceAvailable
                                        }),
                                    child: Container(
                                      width: screenWidthhSize / 5,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color: primaryColor,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: SvgPicture.asset(
                                              'assets/images/wallet_images/transfer_coin.svg',
                                              color: primaryColor,
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Transferir',
                                            style: textStyle.copyWith(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => Get.toNamed(
                                        Routes.WALLET_COIN_WITHDRAW_VIEW,
                                        arguments: {
                                          'mafaAmmount': _controller
                                              .currentMafaBalance
                                              .value
                                              .balanceAvailable
                                        }),
                                    child: Container(
                                      width: screenWidthhSize / 5,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color: primaryColor,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: SvgPicture.asset(
                                              'assets/images/wallet_images/send_coin.svg',
                                              color: primaryColor,
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text('Retirar',
                                              style: textStyle.copyWith(
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ),
                                  )
                                ]))),
                    SizedBox(height: 24),
                    TitleDivider(
                        title: 'Últimas movimentações',
                        actionTitle: (_controller.lastMafaMoviments.value
                                        .transactions?.length ??
                                    0) >
                                3
                            ? "ver todas"
                            : '',
                        onTap: () {
                          _controller.lastMafaMoviments.value.transactions!
                                      .length >
                                  3
                              ? Get.toNamed(Routes.MAFA_EXTRACT_PAGE,
                                  arguments: {
                                      'lastMafaMoviments':
                                          _controller.lastMafaMoviments.value
                                    })
                              : DoNothingAction();
                        }),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            _controller.lastMafaMoviments.value.hasMoviments
                                ? _controller.lastMafaMoviments.value
                                            .transactions!.length >
                                        3
                                    ? 3
                                    : _controller.lastMafaMoviments.value
                                        .transactions!.length
                                : 1,
                        itemBuilder: (context, index) =>
                            _controller.lastMafaMoviments.value.hasMoviments
                                ? LastMovimentsComponent(
                                    imgSrc: _controller.lastMafaMoviments.value
                                        .transactions![index].image,
                                    title: _controller.lastMafaMoviments.value
                                        .transactions![index].title,
                                    toName: _controller.lastMafaMoviments.value
                                        .transactions![index].description,
                                    date: _controller.lastMafaMoviments.value
                                        .transactions![index].date,
                                    amount: _controller.lastMafaMoviments.value
                                            .transactions![index].walletId ??
                                        _controller.lastMafaMoviments.value
                                            .transactions![index].ammount,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: 8, left: 16, right: 24, bottom: 4),
                                    child: Text(
                                      'Não há movimentações a serem mostradas.',
                                      style: textStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                      ),
                    ),
                    SizedBox(height: 24),
                    TitleDivider(title: 'Perguntas frequentes'),
                    Obx(() => ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                        primary: false,
                        padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller.questions.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                _controller.goToAnswer(
                                    _controller.questions[index],
                                    "Perguntas frequentes");
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            bottom: 8,
                                            top: 4),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  child: Expanded(
                                                      child: Text(
                                                '${_controller.questions[index].question}',
                                                textAlign: TextAlign.left,
                                                style: textStyle.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ))),
                                              Icon(
                                                Icons.chevron_right,
                                                color: Colors.white,
                                              ),
                                            ])),
                                    Divider(
                                      color: Colors.white,
                                      height: 1,
                                    ),
                                  ]));
                        })),
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}
