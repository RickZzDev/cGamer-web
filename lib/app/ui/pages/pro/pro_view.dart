import 'dart:io';

import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/controllers/pro/pro_controller.dart';
import 'package:cGamer/app/data/provider/pro_provider/pro_provider.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProView extends StatefulWidget {
  @override
  State<ProView> createState() => _ProViewState();
}

class _ProViewState extends State<ProView> {
  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF27282B));

    Requester client = Requester();

    ProProvider _apiClient = ProProvider(requester: client);
    final ProController _controller = Get.put(
      ProController(
        repository: ProRepository(provider: _apiClient),
      ),
    );

    return MaterialApp(
        home: Obx(() => ModalProgressHUD(
            inAsyncCall: _controller.loading.value,
            child: Scaffold(
                backgroundColor: Color(0xFF131313),
                body: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //colors: [Color(0xffEA4FF9), Color(0xff5869EB)],
                          colors: [Color(0xFF27282B), Color(0xff131313)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: 60,
                              left: 8,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 36,
                                  color: Colors.white,
                                ))),
                        Center(
                            child: Container(
                                margin: EdgeInsets.only(top: 0),
                                child: SizedBox(
                                    child: Image.asset(
                                        'assets/images/gamification_icons/coroa1.png')))),
                        Center(
                            child: Text('Jogga Prime',
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            margin:
                                EdgeInsets.only(top: 16, left: 24, right: 24),
                            child: Text(
                                'Ganhe vantagens sendo um assinante e torne-se um membro exclusivo',
                                textAlign: TextAlign.center,
                                style: textStyle)),
                        Container(
                            margin:
                                EdgeInsets.only(top: 24, left: 24, right: 24),
                            child: Text('Escolha seu plano',
                                textAlign: TextAlign.left,
                                style: textStyle.copyWith(fontSize: 20))),
                        Obx(() => GestureDetector(
                            onTap: () {
                              _controller.isSelectedMonth.value = true;
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 24, left: 24, right: 24, bottom: 16),
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: primaryColor),
                                  color: _controller.isSelectedMonth.value
                                      ? primaryColor
                                      : Color(0xFF131313),
                                ),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Plano mensal',
                                          style:
                                              textStyle.copyWith(fontSize: 16),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'R\$',
                                              style: textStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                                '${_controller.getPrice(true)}',
                                                style: textStyle.copyWith(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              '/mês',
                                              style: textStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        )
                                      ],
                                    ))))),
                        Obx(() => GestureDetector(
                            onTap: () {
                              _controller.isSelectedMonth.value = false;
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: primaryColor),
                                  color: _controller.isSelectedMonth.value
                                      ? Color(0xFF131313)
                                      : primaryColor,
                                ),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Plano anual',
                                          style:
                                              textStyle.copyWith(fontSize: 16),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'R\$',
                                              style: textStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                                '${_controller.getPrice(false)}',
                                                style: textStyle.copyWith(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              '/ano',
                                              style: textStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        )
                                      ],
                                    ))))),
                        Padding(
                            padding: EdgeInsets.all(24),
                            child: GenericButton(
                                text: 'Assinar Jogga Prime',
                                color: primaryColor,
                                txtColor: Colors.white,
                                txtSize: 15,
                                onPressedFunction: () {
                                  _controller.buyPlan(true);
                                })),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _controller.restorePurchase();
                                },
                                child: Text(
                                  'Restaurar assinatura',
                                  style: textStyle.copyWith(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              SizedBox(
                                width: 36,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                      Routes.MARKETPLACE_CONFIRM_TERMS_USE,
                                      arguments: {
                                        "terms_use":
                                            "- Assinatura Prime adquirida pelo app serão cobradas na sua conta ${Platform.isAndroid ? 'da Play Store' : 'iTunes'}, onde você pode gerenciar ou cancelar sua assinatura através das configurações da conta. \n\n - Seu pagamento será renovado automaticamente, a menos que efetue o cancelamento 24h antes do término dos respectivos períodos. \n\n - Sua assinatura é liberada em poucos instantes após concluir a compra pelo App. \n\n - Qualquer dúvida entre em contato através do contato@joggabank.com.br"
                                      });
                                },
                                child: Text(
                                  'Termos e condições',
                                  style: textStyle.copyWith(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ]),
                        SizedBox(height: 24),
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, left: 24, right: 24, bottom: 24),
                            child: Text('Vantagens Jogga Prime',
                                textAlign: TextAlign.left,
                                style: textStyle.copyWith(fontSize: 20))),
                        Obx(() => ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: _controller.benefits.length,
                            itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white38),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                margin: EdgeInsets.only(
                                    left: 24, right: 24, bottom: 16),
                                height: 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 12),
                                        height: 60,
                                        width: 60,
                                        child: Image.network(
                                          _controller.benefits[index].image ??
                                              "",
                                          fit: BoxFit.contain,
                                        )),
                                    SizedBox(width: 12),
                                    Container(
                                        width: screenWidthhSize - 134,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      _controller
                                                              .benefits[index]
                                                              .title ??
                                                          "",
                                                      style: textStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(width: 4),
                                                  _controller.benefits[index]
                                                          .isComingSoon
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  secondaryColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          child: Text(
                                                              'Em breve',
                                                              style: textStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)))
                                                      : Container()
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                  _controller.benefits[index]
                                                          .description ??
                                                      "",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textStyle.copyWith(
                                                      fontSize: 14))
                                            ]))
                                  ],
                                )))),
                        Container(
                            height: 24,
                            margin:
                                EdgeInsets.only(left: 24, top: 24, right: 24),
                            child: Text('Perguntas frequentes',
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        Obx(() => ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            primary: false,
                            padding:
                                EdgeInsets.only(top: 16, left: 24, right: 24),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                        SizedBox(height: 36)
                      ])),
                )))));
  }
}
