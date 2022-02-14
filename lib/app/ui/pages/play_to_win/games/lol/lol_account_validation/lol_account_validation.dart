import 'dart:io';

import 'package:cGamer/app/controllers/play_to_win/games/lol/lol_account_validation/lol_account_validation_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LolAccountValidation extends StatelessWidget {
  final controller = Get.find<LolAccountValidationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                child: CustomAppBar(appBarTxt: "Valide sua conta"),
                preferredSize: Size.fromHeight(60),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vamos validar sua conta ${controller.nick}?',
                      style: textStyle.copyWith(fontSize: 20),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      'Troque o ícone no cliente do jogo pelo da imagem abaixo...Após isso continue =)',
                      style: textStyle.copyWith(
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            'assets/images/play_to_win_games_images/icon-lol-validate.png',
                            fit: BoxFit.contain,
                          )),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 45, vertical: Platform.isAndroid ? 0 : 40),
                child: GenericButton(
                  text: 'Troquei meu ícone',
                  txtColor: Colors.white,
                  onPressedFunction: () => controller.connectAccount(),
                ),
              )),
        ));
  }
}
