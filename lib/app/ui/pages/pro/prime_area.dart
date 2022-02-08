import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/controllers/pro/prime_area_controller.dart';
import 'package:cGamer/app/controllers/pro/pro_controller.dart';
import 'package:cGamer/app/data/provider/pro_provider/pro_provider.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PrimeArea extends StatefulWidget {
  @override
  State<PrimeArea> createState() => _PrimeAreaState();
}

class _PrimeAreaState extends State<PrimeArea> {
  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF27282B));

    final PrimeAreaController _controller = Get.find<PrimeAreaController>();

    return MaterialApp(
        home: Obx(() => ModalProgressHUD(
            inAsyncCall: _controller.loading.value,
            child: Scaffold(
                backgroundColor: Color(0xff131313),
                body: Container(
                  child: SingleChildScrollView(
                      child: Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 260,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 260,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF27282B),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(24),
                                                  bottomRight:
                                                      Radius.circular(24))),
                                        ),
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
                                                  Icons.arrow_back_ios,
                                                  size: 28,
                                                  color: Colors.white,
                                                ))),
                                        Center(
                                            child: Container(
                                          margin: EdgeInsets.only(top: 60),
                                          child: Column(
                                            children: [
                                              Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 80,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            secondaryColor,
                                                        child: _controller
                                                                        .userStats
                                                                        .customerAvatar ==
                                                                    null ||
                                                                _controller
                                                                        .userStats
                                                                        .customerAvatar ==
                                                                    ""
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/tab_bar_icons/Perfil.svg',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  color:
                                                                      primaryColor,
                                                                  height: 24,
                                                                  width: 24,
                                                                ),
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            95.0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: _controller
                                                                          .userStats
                                                                          .customerAvatar ??
                                                                      "",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 80,
                                                                  width: 80,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 120,
                                                      width: 120,
                                                      child: CachedNetworkImage(
                                                          imageUrl: _controller
                                                                  .userStats
                                                                  .level
                                                                  ?.newFrameUrl ??
                                                              "",
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                          height: 50,
                                                          width: 50,
                                                          cacheKey: _controller
                                                                  .userStats
                                                                  .level
                                                                  ?.newFrameUrl ??
                                                              "",
                                                          useOldImageOnUrlChange:
                                                              true,
                                                          fit: BoxFit.cover),
                                                    ),
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: GestureDetector(
                                                        onTap: () => {},
                                                      ),
                                                    ),
                                                  ]),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 24,
                                                      top: 12,
                                                      right: 24),
                                                  child: Text(
                                                      'Olá, ${_controller.userStats.customerNick}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: textStyle.copyWith(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 24, right: 24),
                                                  child: Text(
                                                      'Bem vindo a sua área Prime',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: textStyle.copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500)))
                                            ],
                                          ),
                                        )),
                                      ],
                                    )),
                                Container(
                                    height: 24,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 24, right: 24),
                                    child: Text('Sua assinatura',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    width: screenWidthhSize,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF27282B),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    margin: EdgeInsets.only(
                                        left: 24, top: 24, right: 24),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 16),
                                        Icon(Icons.calendar_today_outlined,
                                            color: primaryColor),
                                        SizedBox(width: 8),
                                        Text('Vencimento em ',
                                            style: textStyle.copyWith(
                                                fontSize: 14)),
                                        Text(
                                            _controller.infoModel.value
                                                    .expiredAt ??
                                                "",
                                            style: textStyle.copyWith(
                                                fontSize: 14,
                                                color: primaryColor))
                                      ],
                                    )),
                                Container(
                                    height: 24,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 16, right: 24),
                                    child: Text('Discord: Cargo Prime',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                GestureDetector(
                                    onTap: () async {
                                      _controller.infoModel.value.discordId ==
                                              null
                                          ? _controller.openConnectDiscord()
                                          : DoNothingAction();
                                    },
                                    child: Obx(() => Container(
                                          margin: EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: 12,
                                              bottom: 8),
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF27282B),
                                            border: Border.all(
                                                color: _controller.infoModel
                                                            .value.discordId !=
                                                        null
                                                    ? primaryColor
                                                    : Color(0xFF588AEA)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 16,
                                              ),
                                              SvgPicture.asset(
                                                "assets/images/home_images/discord.svg",
                                                color: _controller.infoModel
                                                            .value.discordId !=
                                                        null
                                                    ? primaryColor
                                                    : Color(0xFF588AEA),
                                                height: 48,
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(() => Text(
                                                        _controller
                                                                    .infoModel
                                                                    .value
                                                                    .discordId !=
                                                                null
                                                            ? 'Parabéns, conta conectada!'
                                                            : 'Clique para',
                                                        style:
                                                            textStyle.copyWith(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                  Obx(() => Text(
                                                        _controller
                                                                    .infoModel
                                                                    .value
                                                                    .discordId !=
                                                                null
                                                            ? 'Cargo Prime foi adicionado'
                                                            : 'Conectar conta do Discord',
                                                        style:
                                                            textStyle.copyWith(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ))),
                                Container(
                                    height: 24,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 16, right: 24),
                                    child: Text('Recompensas',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    width: double.infinity,
                                    height: 150,
                                    margin: EdgeInsets.only(top: 16),
                                    child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            width: 12,
                                          );
                                        },
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _controller.infoModel.value
                                                .rewards?.length ??
                                            0,
                                        shrinkWrap: true,
                                        primary: false,
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16, bottom: 8),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF27282B),
                                                border: Border.all(
                                                    color: secondaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                    width: 100,
                                                    height: 70,
                                                    child: Image.network(
                                                      _controller
                                                              .infoModel
                                                              .value
                                                              .rewards?[index]
                                                              .image ??
                                                          "",
                                                      fit: BoxFit.contain,
                                                    )),
                                                Text(
                                                    _controller
                                                            .infoModel
                                                            .value
                                                            .rewards?[index]
                                                            .title ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: textStyle.copyWith(
                                                        fontSize: 16)),
                                                Container(
                                                    width: 100,
                                                    child: GenericButton(
                                                        text: 'Resgatar',
                                                        color: primaryColor,
                                                        height: 24,
                                                        enabled: _controller
                                                                .infoModel
                                                                .value
                                                                .rewards?[index]
                                                                .enabled ??
                                                            false,
                                                        onPressedFunction:
                                                            () async {
                                                          if (_controller
                                                                  .infoModel
                                                                  .value
                                                                  .rewards?[
                                                                      index]
                                                                  .enabled ??
                                                              false) {
                                                            await _controller
                                                                .rescueReward(_controller
                                                                        .infoModel
                                                                        .value
                                                                        .rewards?[
                                                                            index]
                                                                        .id ??
                                                                    -1);
                                                          } else {
                                                            if (_controller
                                                                    .infoModel
                                                                    .value
                                                                    .rewards?[
                                                                        index]
                                                                    .title
                                                                    ?.contains(
                                                                        'NFT') ??
                                                                false) {
                                                              SnackBarUtils.showSnackBar(
                                                                  desc:
                                                                      'Assim que liberamos essa funcionalidade, você será um dos primeiros a receber com exclusividade!',
                                                                  title:
                                                                      'Olá, =)',
                                                                  color: Colors
                                                                          .orange[
                                                                      400]);
                                                            } else {
                                                              SnackBarUtils
                                                                  .showSnackBar(
                                                                      desc:
                                                                          'A recompensa já foi resgatada, aguarde um próximo Drop para realizar mais resgates.',
                                                                      title:
                                                                          'Atenção');
                                                            }
                                                          }
                                                        })),
                                              ],
                                            ),
                                          );
                                        })),
                                Container(
                                    height: 24,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 24, right: 24),
                                    child: Text('Benefícios Prime',
                                        textAlign: TextAlign.center,
                                        style: textStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    child: Column(children: [
                                  Container(
                                      width: double.infinity,
                                      height: 160,
                                      margin: EdgeInsets.only(top: 16),
                                      child: Obx(() => ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: 12,
                                            );
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              _controller.benefits.length,
                                          shrinkWrap: true,
                                          primary: false,
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, bottom: 8),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  _controller
                                                      .indexBenefitSelected
                                                      .value = _controller
                                                              .indexBenefitSelected
                                                              .value ==
                                                          index
                                                      ? 99
                                                      : index;
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF27282B),
                                                      border: Border.all(
                                                        color: _controller
                                                                    .indexBenefitSelected
                                                                    .value ==
                                                                index
                                                            ? primaryColor
                                                            : secondaryColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                          width: 100,
                                                          height: 70,
                                                          child: Image.network(
                                                            _controller
                                                                    .benefits[
                                                                        index]
                                                                    .image ??
                                                                "",
                                                            fit: BoxFit.contain,
                                                          )),
                                                      Text(
                                                          _controller
                                                                  .benefits[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: textStyle
                                                              .copyWith(
                                                                  fontSize:
                                                                      15)),
                                                      Icon(
                                                          Icons.arrow_drop_down,
                                                          color: primaryColor)
                                                      // Container(
                                                      //     width: 100,
                                                      //     child: GenericButton(
                                                      //         text: 'Resgatar',
                                                      //         color: primaryColor,
                                                      //         height: 24,
                                                      //         onPressedFunction: () {
                                                      //           // TODO: chamar serviço - resgatar
                                                      //           //
                                                      //           //
                                                      //         })),
                                                    ],
                                                  ),
                                                ));
                                          }))),
                                  _controller.indexBenefitSelected.value == 99
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              top: 12, right: 24, left: 24),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF27282B),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              border: Border.all(
                                                  color: primaryColor)),
                                          width: screenWidthhSize,
                                          child: Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _controller
                                                              .benefits[_controller
                                                                  .indexBenefitSelected
                                                                  .value]
                                                              .title ??
                                                          "",
                                                      style: textStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      _controller
                                                              .benefits[_controller
                                                                  .indexBenefitSelected
                                                                  .value]
                                                              .description ??
                                                          "",
                                                      style: textStyle.copyWith(
                                                          fontSize: 14),
                                                    ),
                                                  ])))
                                ])),
                                Container(
                                    height: 24,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 24, right: 24),
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
                                    padding: EdgeInsets.only(
                                        top: 16, left: 24, right: 24),
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
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              child: Expanded(
                                                                  child: Text(
                                                            '${_controller.questions[index].question}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: textStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
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
                                SizedBox(height: 60),
                              ]))),
                )))));
  }
}
