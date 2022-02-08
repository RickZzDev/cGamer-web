import 'dart:math';

import 'package:cGamer/app/data/models/clans_models/clan_quiz_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_machine_trophy_repository.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_quiz_repository.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_trophy_hunt_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  final QuizRepository repository;

  QuizController(this.repository);

  var loading = false.obs;
  var isAnimating = false.obs;
  var waitingNext = false.obs;
  var timestamp = 0.obs;
  var currentQuestion = 1.obs;
  var timeIsUp = false.obs;
  var optionSelected = "".obs;
  var optionCorrect = "".obs;
  var hasError = false.obs;
  var finishQuestions = false.obs;

  Rx<ClanQuizModel> model = ClanQuizModel([]).obs;

  @override
  void onInit() async {
    await getQuestions();
    // buildAnswers();
    super.onInit();
  }

  Future<bool> getQuestions() async {
    loading.value = true;
    try {
      var response = await repository.getQuestions();
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return false;
      }

      this.model.value = response;

      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  Future<bool> startQuiz() async {
    loading.value = true;
    try {
      var response = await repository.startQuiz();
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return false;
      }
      DartNotificationCenter.post(channel: 'refreshCla');
      timestamp.value = getTimestamp();
      isAnimating.value = true;
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  // void buildAnswers() {
  //   List<QuizQuestion> questions = [];
  //   QuizQuestion question1 = QuizQuestion();
  //   question1.title = "Quem descobriu o Brasil?";
  //   question1.difficulty = "EASY";
  //   question1.id = 1;
  //   question1.qtdTrophy = 3;

  //   List<QuizAnswer> answersQ1 = [];

  //   QuizAnswer answerQ1A = QuizAnswer();
  //   answerQ1A.title = "Pedro de Lara";
  //   answerQ1A.letter = "A";
  //   answersQ1.add(answerQ1A);

  //   QuizAnswer answerQ1B = QuizAnswer();
  //   answerQ1B.title = "Pedro Álvares Cabral";
  //   answerQ1B.letter = "B";
  //   answersQ1.add(answerQ1B);

  //   QuizAnswer answerQ1C = QuizAnswer();
  //   answerQ1C.title = "Elon Musk";
  //   answerQ1C.letter = "C";
  //   answersQ1.add(answerQ1C);

  //   QuizAnswer answerQ1D = QuizAnswer();
  //   answerQ1D.title = "Silvio Santos";
  //   answerQ1D.letter = "D";
  //   answersQ1.add(answerQ1D);
  //   question1.answers = answersQ1;

  //   QuizQuestion question2 = QuizQuestion();
  //   question2.title = "Quantas estações tem no Brasil?";
  //   question2.difficulty = "MEDIUM";
  //   question2.id = 2;
  //   question2.qtdTrophy = 5;

  //   List<QuizAnswer> answersQ2 = [];

  //   QuizAnswer answerQ2A = QuizAnswer();
  //   answerQ2A.title = "2";
  //   answerQ2A.letter = "A";
  //   answersQ2.add(answerQ2A);

  //   QuizAnswer answerQ2B = QuizAnswer();
  //   answerQ2B.title = "5";
  //   answerQ2B.letter = "B";
  //   answersQ2.add(answerQ2B);

  //   QuizAnswer answerQ2C = QuizAnswer();
  //   answerQ2C.title = "4";
  //   answerQ2C.letter = "C";
  //   answersQ2.add(answerQ2C);

  //   QuizAnswer answerQ2D = QuizAnswer();
  //   answerQ2D.title = "3";
  //   answerQ2D.letter = "D";
  //   answersQ2.add(answerQ2D);
  //   question2.answers = answersQ2;

  //   QuizQuestion question3 = QuizQuestion();
  //   question3.title = "Onde o Brasil ganhou sua ultima Copa do Mundo?";
  //   question3.difficulty = "HARD";
  //   question3.id = 3;
  //   question3.qtdTrophy = 10;

  //   List<QuizAnswer> answersQ3 = [];

  //   QuizAnswer answerQ3A = QuizAnswer();
  //   answerQ3A.title = "Coréia do Sul";
  //   answerQ3A.letter = "A";
  //   answersQ3.add(answerQ3A);

  //   QuizAnswer answerQ3B = QuizAnswer();
  //   answerQ3B.title = "Japão";
  //   answerQ3B.letter = "B";
  //   answersQ3.add(answerQ3B);

  //   QuizAnswer answerQ3C = QuizAnswer();
  //   answerQ3C.title = "China";
  //   answerQ3C.letter = "C";
  //   answersQ3.add(answerQ3C);

  //   QuizAnswer answerQ3D = QuizAnswer();
  //   answerQ3D.title = "Estados Unidos";
  //   answerQ3D.letter = "D";
  //   answersQ3.add(answerQ3D);
  //   question3.answers = answersQ3;

  //   questions.add(question1);
  //   questions.add(question2);
  //   questions.add(question3);

  //   model.value.questions = questions;
  // }

  void tapA() {
    if (timestamp.value != 0) {
      optionSelected.value = "A";
      openConfirmModal(0);
    }
  }

  void tapB() {
    if (timestamp.value != 0) {
      optionSelected.value = "B";
      openConfirmModal(1);
    }
  }

  void tapC() {
    if (timestamp.value != 0) {
      optionSelected.value = "C";
      openConfirmModal(2);
    }
  }

  void tapD() {
    if (timestamp.value != 0) {
      optionSelected.value = "D";
      openConfirmModal(3);
    }
  }

  void clear() {
    optionSelected.value = "";
    timestamp.value = 0;
    timeIsUp.value = false;
    waitingNext.value = false;
    optionCorrect.value = "";
    hasError.value = false;
  }

  void openConfirmModal(int indexLetter) {
    showModalBottomSheet(
        backgroundColor: secondaryColor,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: Get.context!,
        builder: (context) {
          return Builder(
              builder: (context) => Container(
                  width: screenWidthhSize,
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text('Você está certo disso?',
                          style: textStyle.copyWith()),
                      Container(
                        width: screenWidthhSize,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                        height: 60,
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                height: 30,
                                width: 30,
                                child: Center(
                                    child: Text(
                                  optionSelected.value,
                                  style:
                                      textStyle.copyWith(color: secondaryColor),
                                ))),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: Text(
                                        '${model.value.questions[currentQuestion.value - 1].answers[indexLetter].title}',
                                        style: textStyle.copyWith(
                                          fontSize: 13,
                                        )))),
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.white, width: 2)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Posso perguntar?', style: textStyle.copyWith()),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 150,
                              child: GenericButton(
                                  text: 'Não',
                                  color: Colors.white70,
                                  onPressedFunction: () {
                                    Get.back();
                                  })),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                              width: 150,
                              child: GenericButton(
                                  text: 'Sim',
                                  color: primaryColor,
                                  onPressedFunction: () {
                                    callAnswer();
                                    Get.back();
                                  })),
                        ],
                      )
                    ],
                  )));
        });
  }

  Future<bool> sendAnswer(int questionId, String letter) async {
    loading.value = true;
    try {
      var response = await repository.sendAnswer(questionId, letter);
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
      }
      loading.value = false;

      String correctLetter = response.correctLetter;
      if (correctLetter == optionSelected.value) {
        setCorrectAnswer(correctLetter);
        if (currentQuestion.value < 3) {
          waitingNext.value = true;
        } else {
          waitingNext.value = false;
          finishQuestions.value = true;
        }
      } else {
        setErrorAnswer(correctLetter);
      }

      DartNotificationCenter.post(channel: 'refreshCla');
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      loading.value = false;
      return false;
    }
  }

  Future<void> start() async {
    if (currentQuestion.value == 1) {
      //chamar serviço PUT para startar quiz
      await startQuiz();
    } else {
      timestamp.value = getTimestamp();
      isAnimating.value = true;
    }
  }

  Future<void> finish() async {
    if (timestamp.value != 0) {
      isAnimating.value = false;
      timeIsUp.value = true;
    }
  }

  Future<void> next() async {
    if (currentQuestion.value < model.value.questions.length) {
      currentQuestion.value = currentQuestion.value + 1;
    }

    clear();
  }

  int getTimestamp() {
    DateTime dateLastAction = DateTime.now();
    DateTime dateNextAction = dateLastAction.add(Duration(seconds: 40));
    return dateNextAction.millisecondsSinceEpoch;
  }

  Future<void> callAnswer() async {
    isAnimating.value = false;
    timestamp.value = 0;
    //chamar endpoint para verificar se resposta esta correta
    await sendAnswer(model.value.questions[currentQuestion.value - 1].id ?? -1,
        optionSelected.value);
  }

  void setCorrectAnswer(String letter) {
    optionCorrect.value = letter;
  }

  void setErrorAnswer(String correctLetter) {
    hasError.value = true;
    setCorrectAnswer(correctLetter);
  }
}
