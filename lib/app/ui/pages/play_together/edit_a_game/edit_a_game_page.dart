import 'package:cGamer/app/controllers/play_together_controllers/edit_game_controller/edit_game_controller.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditAGamePage extends StatefulWidget {
  @override
  State<EditAGamePage> createState() => _EditAGamePageState();
}

class _EditAGamePageState extends State<EditAGamePage> {
  final _controller = Get.find<EditGameController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.isLoading,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
              child: CustomAppBar(
                appBarTxt: "${_controller.editGameModel.game.title}",
              ),
              preferredSize: Size.fromHeight(60)),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Image.network(
                                  _controller.editGameModel.game.image ?? "",
                                  fit: BoxFit.cover)))),
                  SizedBox(height: 24),
                  CustomTextField(
                    controller: _controller.nickController,
                    validation: _controller.nickVerification,
                    labelText: 'Nome de usuário',
                    autoFocus: false,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GenericButton(
                      text: "Excluir Jogo",
                      color: Colors.white70,
                      icon: Icons.remove_circle_rounded,
                      onPressedFunction: () async {
                        await _controller.removeAGame();
                        Navigator.pop(context);
                      },
                      txtColor: secondaryColor,
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: GenericButton(
                      text: "Salvar",
                      color: primaryColor,
                      icon: Icons.save,
                      onPressedFunction: () {
                        if (_controller.isValidForm) {
                          _controller.editAGame();
                        } else {
                          SnackBarUtils.showSnackBar(
                              desc: "Preencha o nick corretamente.",
                              title: "Atenção");
                        }
                      },
                      txtColor: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
