import 'package:cGamer/app/controllers/play_together_controllers/play_together_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/play_together_components/play_together/play_together_switch.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PlayTogetherPage extends StatefulWidget {
  PlayTogetherPage({Key? key}) : super(key: key);

  @override
  State<PlayTogetherPage> createState() => _PlayTogetherPageState();
}

class _PlayTogetherPageState extends State<PlayTogetherPage> {
  final PlayTogetherController controller = Get.find<PlayTogetherController>();

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarColor(primaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: CustomAppBar(
              statusBar: SystemUiOverlayStyle(statusBarColor: secondaryColor),
              appBarTxt: "Encontre um Gamer",
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: IconButton(
                        tooltip: "Conexões",
                        onPressed: () => Get.toNamed(Routes.CONNECTIONS,
                            arguments: {'fromHome': false}),
                        icon: SvgPicture.asset(
                            'assets/images/play_together/icon_conexoes.svg',
                            color: primaryColor)))
              ],
            ),
            preferredSize: Size.fromHeight(60),
          ),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => PlayTogetherSwitch(
                    value: RxBool(controller.beFound.value),
                    onTap: (value) async {
                      await controller.changeBeFound(value);
                    },
                  )),
              _InfoText(),
              PlatformSelection(
                onTap: (index) async {
                  controller.indexPlatformSelected.value = index;
                  await controller.getGamesFromPlatform(index);
                },
              ),
              Divider(
                color: Colors.transparent,
              ),
              Obx(() => GameSelection(
                    onTapToSelect: (isSelected, index) {
                      controller.hasSelectedGame.value = isSelected;
                      controller.gameSelected =
                          controller.gamesPlatform?[index - 1];
                    },
                    platformId: controller.indexPlatformSelected.value,
                    games: controller.gamesPlatform?.value ?? [],
                  )),
            ],
          )),
          bottomNavigationBar: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Obx(() => GenericButton(
                          enabled: controller.hasSelectedGame.value,
                          text: "Próximo a mim",
                          color: Colors.white.withOpacity(0.85),
                          icon: Icons.location_on_outlined,
                          onPressedFunction: () async {
                            if (controller.hasSelectedGame.value) {
                              if (controller.position != null) {
                                controller.hasSelectedGame.value = false;
                                Get.toNamed(Routes.PLAYER_SEARCH, arguments: {
                                  "from": "NEARBY",
                                  "gameId": controller.gameSelected?.id ?? 0,
                                  "gameImage":
                                      controller.gameSelected?.image ?? "",
                                  "platformId":
                                      controller.indexPlatformSelected.value
                                });
                              } else {
                                SnackBarUtils.showSnackBar(
                                    desc:
                                        'A busca será liberada em alguns segundos..',
                                    title: "Aguarde",
                                    color: Colors.orange[400]);
                              }
                            } else {
                              SnackBarUtils.showSnackBar(
                                  desc:
                                      'Selecione um jogo acima, antes de iniciar a busca!',
                                  title: 'Atenção',
                                  color: Colors.orange[400]);
                            }
                          },
                          txtColor: secondaryColor,
                        )),
                  ),
                  VerticalDivider(
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: Obx(() => GenericButton(
                          text: "Partida Rápida",
                          color: primaryColor,
                          icon: Icons.group_rounded,
                          enabled: controller.hasSelectedGame.value,
                          onPressedFunction: () {
                            if (controller.hasSelectedGame.value) {
                              controller.hasSelectedGame.value = false;
                              Get.toNamed(Routes.PLAYER_SEARCH, arguments: {
                                "from": "FASTMATCH",
                                "gameId": controller.gameSelected?.id ?? 0,
                                "gameImage":
                                    controller.gameSelected?.image ?? "",
                                "platformId":
                                    controller.indexPlatformSelected.value
                              });
                            } else {
                              SnackBarUtils.showSnackBar(
                                  desc:
                                      'Selecione um jogo acima, antes de iniciar a busca!',
                                  title: 'Atenção',
                                  color: Colors.orange[400]);
                            }
                          },
                          txtColor: secondaryColor,
                        )),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Row(
        children: [
          Text(
            "Encontre um gamer e ",
            style: textStyle,
          ),
          Text(
            "Jogue Junto",
            style: textStyle.copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }
}
