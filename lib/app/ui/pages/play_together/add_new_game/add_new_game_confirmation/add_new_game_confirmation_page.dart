import 'package:cGamer/app/controllers/play_together_controllers/add_game_confirmation_controller/add_game_confirmation_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddNewGameConfirmationPage extends StatelessWidget {
  AddNewGameConfirmationPage({Key? key}) : super(key: key);
  final AddGameConfirmationController controller =
      Get.find<AddGameConfirmationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.isLoading,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: CustomAppBar(
                appBarTxt:
                    controller.model.addGameModel.title ?? "Adicionar jogo"),
            preferredSize: Size.fromHeight(60),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Insira o nome de usuário",
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    validation: controller.nickValidation,
                    controller: controller.userNameController,
                    labelText: "Nome de usuário",
                    autoFocus: false,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(() => PlatformChoiceGrid(
                        onTap: (index) {
                          controller.reactiveList.value![index].isSelected =
                              !controller.reactiveList.value![index].isSelected;
                          controller.reactiveList.refresh();
                        },
                        platforms: controller.reactiveList.value ?? [],
                      ))
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100,
            child: Container(
              margin: EdgeInsets.fromLTRB(32, 0, 32, 60),
              child: GenericButton(
                height: 30,
                text: "Adicionar jogo",
                onPressedFunction: controller.postNewGame,
                txtColor: secondaryColor,
              ),
            ),
          ),
        )));
  }
}
