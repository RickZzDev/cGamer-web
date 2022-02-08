import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class ClanQuizModel {
  late List<QuizQuestion> questions;

  ClanQuizModel(this.questions);

  ClanQuizModel.fromJson(Map<String, dynamic> json) {
    this.questions = <QuizQuestion>[];
    if (json['questions'] != null) {
      json['questions'].forEach(
          (object) => this.questions.add(QuizQuestion.fromJson(object)));
    }
  }
}

class QuizQuestion {
  int? id;
  String? title;
  String? difficulty;
  int? qtdTrophy;
  late List<QuizAnswer> answers;

  QuizQuestion();

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    difficulty = json['difficulty'];
    qtdTrophy = json['qtdTrophy'];
    answers = [];
    if (json['answers'] != null) {
      json['answers']
          .forEach((object) => answers.add(QuizAnswer.fromJson(object)));
    }
  }
}

class QuizAnswer {
  String? title;
  String? letter;

  QuizAnswer();

  QuizAnswer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    letter = json['letter'];
  }
}

class CorrectAnswerModel {
  String? correctLetter;

  CorrectAnswerModel();

  CorrectAnswerModel.fromJson(Map<String, dynamic> json) {
    this.correctLetter = json['correctLetter'];
  }
}
