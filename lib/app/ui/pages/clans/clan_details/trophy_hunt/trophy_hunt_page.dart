import 'package:cGamer/app/controllers/clan_controllers/clan_trophy_hunt_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/screen_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TrophyHunt extends StatelessWidget {
  TrophyHunt({Key? key}) : super(key: key);

  final _controller = Get.find<ClanTrophyHuntController>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: screenWidthhSize,
        child: Image.asset(
          'assets/images/cla_images/fundo_caca.png',
          fit: BoxFit.cover,
          height: screenHeigthSize,
          width: screenWidthhSize,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            child: CustomAppBar(
              statusBar:
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              appBarTxt: "Caça aos troféus",
            ),
            preferredSize: Size.fromHeight(60)),
        body: Obx(() => _controller.isLoading
            ? ModalProgressHUD(
                inAsyncCall: true,
                child: SizedBox(),
              )
            : Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Rodada reinicia em: ',
                          style: textStyle.copyWith(fontSize: 14),
                        ),
                        CountdownTimer(
                          endTime: _controller.getTimestamp(),
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            if (time == null) {
                              return Text(
                                "Rodada sendo encerrada..",
                                style: textStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              );
                            }
                            return Container(
                                child: Text(
                                    time.sec! < 10
                                        ? '${time.hours ?? 0}:${time.min ?? 0}:0${time.sec}'
                                        : '${time.hours ?? 0}:${time.min ?? 0}:${time.sec}',
                                    style: textStyle.copyWith(
                                        fontSize: 30,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)));
                          },
                        ),
                        Text(
                          'A busca por troféus é reiniciada de hora em hora!',
                          style: textStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                    MembersCloud(
                      members: _controller.model.hunterTrophy.hunters,
                    ),
                    Container(
                        width: screenWidthhSize,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: EdgeInsets.all(16),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          elevation: 8,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                      'assets/images/cla_images/bag.png')),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Super mochila!',
                                    style: textStyle.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Armazene mais troféus!',
                                    style: textStyle.copyWith(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Equipe sua mochila antes de ir.',
                                    style: textStyle.copyWith(
                                        color: secondaryColor, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Obx(() => GenericButton(
                                      text: _controller.bagIsEquiped.value
                                          ? 'Mochila equipada'
                                          : _controller
                                                  .model.hunterTrophy.hunting
                                              ? 'Aguarde próxima rodada'
                                              : 'Equipar mochila',
                                      color: primaryColor,
                                      height: 40,
                                      enabled: _controller
                                          .btnDuplicateIsEnabled.value,
                                      txtColor: Colors.white,
                                      onPressedFunction: _controller
                                              .btnDuplicateIsEnabled.value
                                          ? _controller.equipBag
                                          : () {},
                                      rightIcon:
                                          _controller.bagIsEquiped.value ||
                                                  _controller.model.hunterTrophy
                                                      .hunting
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/gamification_icons/cristal.png',
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      _controller
                                                          .model
                                                          .hunterTrophy
                                                          .payPoints
                                                          .toString(),
                                                      style: textStyle,
                                                    )
                                                  ],
                                                )))
                                ],
                              )
                            ],
                          ),
                        )),
                    GenericButton(
                        text: _controller.model.hunterTrophy.hunting
                            ? 'Já está caçando nessa rodada'
                            : 'Ir caçar com o clã',
                        txtColor: Colors.white,
                        enabled: !_controller.model.hunterTrophy.hunting,
                        onPressedFunction:
                            _controller.model.hunterTrophy.hunting
                                ? () {}
                                : () {
                                    _controller.postBag();
                                  }),
                  ],
                ),
              )),
      )
    ]);
  }
}
