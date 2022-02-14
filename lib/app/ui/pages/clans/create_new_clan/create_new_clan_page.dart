import 'dart:io';

import 'package:cGamer/app/controllers/clan_controllers/create_new_clan_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/create_new_clan_components/clan_emblem.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateNewClan extends StatelessWidget {
  final _controller = Get.find<CreateNewClanController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              appBarTxt: 'Criar meu clã',
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Obx(() => ClanEmblem(
                          urlImage: _controller.currentEmblem.value,
                          addNewEmblemAction: _controller.openChooseEmblemModal,
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Escolha um nome',
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      controller: _controller.clanNameController,
                      labelText: 'Nome do clã',
                      autoFocus: false,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          'Escreva uma descrição  ',
                          style: textStyle,
                        ),
                        Text(
                          '(Opcional)',
                          style: textStyle.copyWith(
                              color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DescriptionField(
                        textEditingController:
                            _controller.clanDescriptionController),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, Platform.isIOS ? 36 : 24),
            child: GenericButton(
              text: 'Criar meu clã',
              onPressedFunction: _controller.postNewClan,
              txtColor: Colors.white,
            ),
          ),
        )));
  }
}
