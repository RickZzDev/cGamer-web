import 'package:cGamer/app/controllers/clan_controllers/clan_jogo_velha_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_quiz_controller.dart';
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
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key}) : super(key: key);

  final _controller = Get.find<QuizController>();

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
                  appBarTxt: "Quiz: Acerte e Ganhe",
                ),
                preferredSize: Size.fromHeight(60)),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: [
                    _controller.isAnimating.value ||
                            _controller.waitingNext.value ||
                            _controller.timeIsUp.value ||
                            _controller.hasError.value ||
                            _controller.finishQuestions.value
                        ? Container()
                        : Container(
                            width: screenWidthhSize,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                        'assets/images/cla_images/answer.png')),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controller.currentQuestion.value == 1
                                          ? 'Vamos testar seus conhecimentos?'
                                          : _controller.currentQuestion.value ==
                                                  2
                                              ? '2ª pergunta! Esta indo bem.'
                                              : 'Uau, última pergunta!',
                                      style: textStyle.copyWith(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Acerte a resposta e ganhe troféus',
                                      style: textStyle.copyWith(
                                          color: secondaryColor, fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                    Obx(() => Container(
                          height: 100,
                          child: Lottie.asset('assets/animations/30sec.json',
                              repeat: _controller.isAnimating.value),
                        )),
                    Center(child: SizedBox()),
                    Obx(() => _controller.timestamp.value != 0
                        ? Obx(() => CountdownTimer(
                              endTime: _controller.timestamp.value,
                              onEnd: () {
                                _controller.finish();
                              },
                              widgetBuilder: (_, CurrentRemainingTime? time) {
                                if (time == null) {
                                  return Container(
                                      width: 150,
                                      child: GenericButton(
                                          text: 'Tempo esgotado',
                                          txtColor: Colors.white,
                                          color: secondaryColor,
                                          onPressedFunction: () {}));
                                }
                                return Container(
                                    width: 150,
                                    child: GenericButton(
                                        text: time.sec! < 10
                                            ? '0${time.min ?? 0}:0${time.sec}'
                                            : '0${time.min ?? 0}:${time.sec}',
                                        txtColor: Colors.white,
                                        color: secondaryColor,
                                        txtSize: 16,
                                        onPressedFunction: () {}));
                              },
                            ))
                        : !_controller.waitingNext.value &&
                                !_controller.hasError.value &&
                                !_controller.finishQuestions.value
                            ? GestureDetector(
                                onTap: () {
                                  _controller.start();
                                },
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Text(
                                    "Iniciar",
                                    style: textStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ))
                            : Container(
                                child: Text(
                                    _controller.hasError.value
                                        ? 'Resposta errada :(\nTente novamente mais tarde!'
                                        : "Resposta correta!\nVocê ganhou ${_controller.model.value.questions[_controller.currentQuestion.value - 1].qtdTrophy} troféus!",
                                    textAlign: TextAlign.center,
                                    style: textStyle.copyWith(
                                        color: _controller.hasError.value
                                            ? Colors.red.withOpacity(0.95)
                                            : primaryColor)))),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Essa pergunta vale ',
                                style: textStyle.copyWith(fontSize: 16)),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              'assets/images/gamification_icons/trophy.png',
                              height: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${_controller.model.value.questions.length > 0 ? _controller.model.value.questions[_controller.currentQuestion.value - 1].qtdTrophy : 0}",
                              style: textStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Obx(() => Text(
                              '${_controller.currentQuestion.value}/${_controller.model.value.questions.length}',
                              style: textStyle.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                            _controller.isAnimating.value ||
                                    _controller.waitingNext.value ||
                                    _controller.hasError.value ||
                                    _controller.finishQuestions.value
                                ? '${_controller.model.value.questions[_controller.currentQuestion.value - 1].title}'
                                : '',
                            style: textStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _controller.hasError.value
                                    ? Colors.red
                                    : (_controller.optionCorrect.value ==
                                                _controller
                                                    .optionSelected.value) &&
                                            _controller.optionSelected.value !=
                                                ""
                                        ? primaryColor
                                        : Colors.white)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: _controller.hasError.value
                                    ? Colors.red
                                    : (_controller.optionCorrect.value ==
                                                _controller
                                                    .optionSelected.value) &&
                                            _controller.optionSelected.value !=
                                                ""
                                        ? primaryColor
                                        : Colors.grey)),
                      ),
                      width: screenWidthhSize,
                      height: 120,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              color: _controller.hasError.value
                                  ? Colors.red
                                  : (_controller.optionCorrect.value ==
                                              _controller
                                                  .optionSelected.value) &&
                                          _controller.optionSelected.value != ""
                                      ? primaryColor
                                      : Colors.grey)),
                    ),
                    GestureDetector(
                        onTap: () {
                          _controller.tapA();
                        },
                        child: Obx(() => Container(
                              width: screenWidthhSize,
                              margin: EdgeInsets.only(top: 12),
                              height: 60,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: _controller
                                                      .optionSelected.value ==
                                                  "A"
                                              ? _controller.hasError.value
                                                  ? Colors.red
                                                  : _controller.optionCorrect
                                                              .value ==
                                                          _controller
                                                              .optionSelected
                                                              .value
                                                      ? primaryColor
                                                      : Colors.white
                                              : _controller.optionCorrect
                                                          .value ==
                                                      "A"
                                                  ? primaryColor
                                                  : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        'A',
                                        style: textStyle.copyWith(
                                            color: secondaryColor),
                                      ))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: Text(
                                              _controller.isAnimating.value ||
                                                      _controller
                                                          .waitingNext.value ||
                                                      _controller
                                                          .hasError.value ||
                                                      _controller
                                                          .finishQuestions.value
                                                  ? '${_controller.model.value.questions[_controller.currentQuestion.value - 1].answers[0].title}'
                                                  : '',
                                              style: textStyle.copyWith(
                                                  fontSize: 13,
                                                  color: _controller
                                                              .optionSelected
                                                              .value ==
                                                          "A"
                                                      ? _controller
                                                              .hasError.value
                                                          ? Colors.red
                                                          : _controller
                                                                      .optionCorrect
                                                                      .value ==
                                                                  _controller
                                                                      .optionSelected
                                                                      .value
                                                              ? primaryColor
                                                              : Colors.white
                                                      : _controller
                                                                  .optionCorrect
                                                                  .value ==
                                                              "A"
                                                          ? primaryColor
                                                          : Colors.white)))),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: _controller.optionSelected.value ==
                                              "A"
                                          ? _controller.hasError.value
                                              ? Colors.red
                                              : _controller.optionCorrect
                                                          .value ==
                                                      _controller
                                                          .optionSelected.value
                                                  ? primaryColor
                                                  : Colors.white
                                          : _controller.optionCorrect.value ==
                                                  "A"
                                              ? primaryColor
                                              : Colors.grey,
                                      width: _controller.optionSelected.value ==
                                                  "A" ||
                                              _controller.optionCorrect.value ==
                                                  "A"
                                          ? 2
                                          : 0.5)),
                            ))),
                    GestureDetector(
                        onTap: () {
                          _controller.tapB();
                        },
                        child: Obx(() => Container(
                              width: screenWidthhSize,
                              margin: EdgeInsets.only(top: 12),
                              height: 60,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: _controller
                                                      .optionSelected.value ==
                                                  "B"
                                              ? _controller.hasError.value
                                                  ? Colors.red
                                                  : _controller.optionCorrect
                                                              .value ==
                                                          _controller
                                                              .optionSelected
                                                              .value
                                                      ? primaryColor
                                                      : Colors.white
                                              : _controller.optionCorrect
                                                          .value ==
                                                      "B"
                                                  ? primaryColor
                                                  : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        'B',
                                        style: textStyle.copyWith(
                                            color: secondaryColor),
                                      ))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: Text(
                                              _controller.isAnimating.value ||
                                                      _controller
                                                          .waitingNext.value ||
                                                      _controller
                                                          .hasError.value ||
                                                      _controller
                                                          .finishQuestions.value
                                                  ? '${_controller.model.value.questions[_controller.currentQuestion.value - 1].answers[1].title}'
                                                  : '',
                                              style: textStyle.copyWith(
                                                  fontSize: 13,
                                                  color: _controller
                                                              .optionSelected
                                                              .value ==
                                                          "B"
                                                      ? _controller
                                                              .hasError.value
                                                          ? Colors.red
                                                          : _controller
                                                                      .optionCorrect
                                                                      .value ==
                                                                  _controller
                                                                      .optionSelected
                                                                      .value
                                                              ? primaryColor
                                                              : Colors.white
                                                      : _controller
                                                                  .optionCorrect
                                                                  .value ==
                                                              "B"
                                                          ? primaryColor
                                                          : Colors.white)))),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: _controller.optionSelected.value ==
                                              "B"
                                          ? _controller.hasError.value
                                              ? Colors.red
                                              : _controller.optionCorrect
                                                          .value ==
                                                      _controller
                                                          .optionSelected.value
                                                  ? primaryColor
                                                  : Colors.white
                                          : _controller.optionCorrect.value ==
                                                  "B"
                                              ? primaryColor
                                              : Colors.grey,
                                      width: _controller.optionSelected.value ==
                                                  "B" ||
                                              _controller.optionCorrect.value ==
                                                  "B"
                                          ? 2
                                          : 0.5)),
                            ))),
                    GestureDetector(
                        onTap: () {
                          _controller.tapC();
                        },
                        child: Obx(() => Container(
                              width: screenWidthhSize,
                              margin: EdgeInsets.only(top: 12),
                              height: 60,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: _controller
                                                      .optionSelected.value ==
                                                  "C"
                                              ? _controller.hasError.value
                                                  ? Colors.red
                                                  : _controller.optionCorrect
                                                              .value ==
                                                          _controller
                                                              .optionSelected
                                                              .value
                                                      ? primaryColor
                                                      : Colors.white
                                              : _controller.optionCorrect
                                                          .value ==
                                                      "C"
                                                  ? primaryColor
                                                  : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        'C',
                                        style: textStyle.copyWith(
                                            color: secondaryColor),
                                      ))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: Text(
                                              _controller.isAnimating.value ||
                                                      _controller
                                                          .waitingNext.value ||
                                                      _controller
                                                          .hasError.value ||
                                                      _controller
                                                          .finishQuestions.value
                                                  ? '${_controller.model.value.questions[_controller.currentQuestion.value - 1].answers[2].title}'
                                                  : '',
                                              style: textStyle.copyWith(
                                                  fontSize: 13,
                                                  color: _controller
                                                              .optionSelected
                                                              .value ==
                                                          "C"
                                                      ? _controller
                                                              .hasError.value
                                                          ? Colors.red
                                                          : _controller
                                                                      .optionCorrect
                                                                      .value ==
                                                                  _controller
                                                                      .optionSelected
                                                                      .value
                                                              ? primaryColor
                                                              : Colors.white
                                                      : _controller
                                                                  .optionCorrect
                                                                  .value ==
                                                              "C"
                                                          ? primaryColor
                                                          : Colors.white)))),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: _controller.optionSelected.value ==
                                              "C"
                                          ? _controller.hasError.value
                                              ? Colors.red
                                              : _controller.optionCorrect
                                                          .value ==
                                                      _controller
                                                          .optionSelected.value
                                                  ? primaryColor
                                                  : Colors.white
                                          : _controller.optionCorrect.value ==
                                                  "C"
                                              ? primaryColor
                                              : Colors.grey,
                                      width: _controller.optionSelected.value ==
                                                  "C" ||
                                              _controller.optionCorrect.value ==
                                                  "C"
                                          ? 2
                                          : 0.5)),
                            ))),
                    GestureDetector(
                        onTap: () {
                          _controller.tapD();
                        },
                        child: Obx(() => Container(
                              width: screenWidthhSize,
                              margin: EdgeInsets.only(top: 12),
                              height: 60,
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: _controller
                                                      .optionSelected.value ==
                                                  "D"
                                              ? _controller.hasError.value
                                                  ? Colors.red
                                                  : _controller.optionCorrect
                                                              .value ==
                                                          _controller
                                                              .optionSelected
                                                              .value
                                                      ? primaryColor
                                                      : Colors.white
                                              : _controller.optionCorrect
                                                          .value ==
                                                      "D"
                                                  ? primaryColor
                                                  : Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        'D',
                                        style: textStyle.copyWith(
                                            color: secondaryColor),
                                      ))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: Text(
                                              _controller.isAnimating.value ||
                                                      _controller
                                                          .waitingNext.value ||
                                                      _controller
                                                          .hasError.value ||
                                                      _controller
                                                          .finishQuestions.value
                                                  ? '${_controller.model.value.questions[_controller.currentQuestion.value - 1].answers[3].title}'
                                                  : '',
                                              style: textStyle.copyWith(
                                                  fontSize: 13,
                                                  color: _controller
                                                              .optionSelected
                                                              .value ==
                                                          "D"
                                                      ? _controller
                                                              .hasError.value
                                                          ? Colors.red
                                                          : _controller
                                                                      .optionCorrect
                                                                      .value ==
                                                                  _controller
                                                                      .optionSelected
                                                                      .value
                                                              ? primaryColor
                                                              : Colors.white
                                                      : _controller
                                                                  .optionCorrect
                                                                  .value ==
                                                              "D"
                                                          ? primaryColor
                                                          : Colors.white)))),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: _controller.optionSelected.value ==
                                              "D"
                                          ? _controller.hasError.value
                                              ? Colors.red
                                              : _controller.optionCorrect
                                                          .value ==
                                                      _controller
                                                          .optionSelected.value
                                                  ? primaryColor
                                                  : Colors.white
                                          : _controller.optionCorrect.value ==
                                                  "D"
                                              ? primaryColor
                                              : Colors.grey,
                                      width: _controller.optionSelected.value ==
                                                  "D" ||
                                              _controller.optionCorrect.value ==
                                                  "D"
                                          ? 2
                                          : 0.5)),
                            ))),
                    _controller.waitingNext.value ||
                            _controller.timeIsUp.value ||
                            _controller.hasError.value ||
                            _controller.finishQuestions.value
                        ? Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 150,
                                    child: GenericButton(
                                        text: 'Finalizar',
                                        color: Colors.white70,
                                        onPressedFunction: () {
                                          Get.back();
                                        })),
                                SizedBox(
                                  width: !_controller.timeIsUp.value ? 12 : 0,
                                ),
                                !_controller.timeIsUp.value &&
                                        _controller.currentQuestion.value < 3 &&
                                        !_controller.hasError.value
                                    ? Container(
                                        width: 150,
                                        child: GenericButton(
                                            text: 'Continuar',
                                            color: primaryColor,
                                            onPressedFunction: () {
                                              _controller.next();
                                            }))
                                    : Container(),
                              ],
                            ))
                        : Container(),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ))));
  }
}
