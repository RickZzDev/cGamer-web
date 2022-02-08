import 'dart:async';

import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/search_player_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PlayerSearchPage extends StatefulWidget {
  const PlayerSearchPage({Key? key}) : super(key: key);

  @override
  State<PlayerSearchPage> createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  final SearchPlayerController controller = Get.find<SearchPlayerController>();

  @override
  void dispose() {
    controller.isCancelled.value = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        child: CustomAppBar(
          appBarTxt: controller.from == "FASTMATCH"
              ? "Partida rápida"
              : "Próximo a mim",
        ),
        preferredSize: Size.fromHeight(60),
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
              width: screenWidthhSize,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 36),
                    Text(
                      controller.from == "FASTMATCH"
                          ? "Buscando um jogador.."
                          : "Buscando jogadores...",
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(),
                    ),
                  ])),
          Container(
            child: Lottie.asset('assets/animations/search-player.json'),
          ),
          Container(
              width: screenWidthhSize,
              height: screenHeigthSize - 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "para o jogo",
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Obx(() => CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: controller.gameImage.value)),
                    ),
                  )
                ],
              )),
        ],
      )),
      bottomNavigationBar: Container(
        height: 100,
        child: Container(
          margin: EdgeInsets.fromLTRB(32, 0, 32, 60),
          child: GenericButton(
            height: 30,
            isTransparentButton: true,
            text: "Cancelar busca",
            onPressedFunction: () {
              controller.isCancelled.value = true;
              Navigator.pop(Get.context!);
            },
            txtColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
