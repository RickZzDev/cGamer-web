import 'package:cGamer/app/controllers/clan_controllers/clan_jogo_velha_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_trophy_hunt_controller.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_machine_trophy_repository.dart';
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

class JogoVelhaPage extends StatelessWidget {
  JogoVelhaPage({Key? key}) : super(key: key);

  final _controller = Get.find<JogoVelhaController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: PreferredSize(
                child: CustomAppBar(
                  statusBar:
                      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                  appBarTxt: "Jogo da Velha",
                ),
                preferredSize: Size.fromHeight(60)),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
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
                                      'assets/images/cla_images/fadinha.png')),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.titleConvesation.value,
                                    style: textStyle.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    _controller.descConversation.value,
                                    style: textStyle.copyWith(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Stack(
                          children: [
                            _buildGrid(),
                            _buildField(),
                          ],
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    GenericButton(
                        text: _controller.isWinner.value
                            ? 'Parabéns, coletar 5 trófeus'
                            : 'Vença para levar 5 troféus',
                        txtColor: Colors.white,
                        enabled: _controller.isWinner.value,
                        onPressedFunction: null),
                    Padding(padding: EdgeInsets.only(bottom: 8))
                  ],
                ),
              ),
            ))));
  }

  _buildGrid() {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              buildHorizontalLine,
              buildHorizontalLine,
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              buildVerticalLine,
              buildVerticalLine,
            ])
          ],
        ));
  }

  Container get buildHorizontalLine {
    return new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      color: secondaryColor,
      height: 5.0,
    );
  }

  Container get buildVerticalLine {
    return new Container(
      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
      color: secondaryColor,
      width: 5.0,
    );
  }

  _buildField() {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  _buildCell(0, 0),
                  _buildCell(0, 1),
                  _buildCell(0, 2),
                ])),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  _buildCell(1, 0),
                  _buildCell(1, 1),
                  _buildCell(1, 2),
                ])),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  _buildCell(2, 0),
                  _buildCell(2, 1),
                  _buildCell(2, 2),
                ])),
          ],
        ));
  }

  _buildCell(int row, int column) {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: GestureDetector(
            onTap: () {
              if (_controller.botIsPlaying.value ||
                  _controller.hasWinner.value) {
                return;
              }
              _controller.changeMatrixField(row, column, false);
              _controller.checkWinner(row, column);
            },
            child: _buildCellItem(row, column)));
  }

  _buildCellItem(int row, int column) {
    var cell = _controller.matrix[row][column];
    if (cell.isNotEmpty) {
      if (cell == 'X') {
        return Container(
          padding: EdgeInsets.all(2.0),
          child: Center(
              child: Text(cell,
                  style: TextStyle(fontSize: 90.0, color: primaryColor))),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(2.0),
          child: Center(
              child: Text(cell,
                  style: TextStyle(fontSize: 90.0, color: secondaryColor))),
        );
      }
    }
  }
}
