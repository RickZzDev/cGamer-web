import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_quiz_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_machine_trophy_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_quiz_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_trophy_hunt_provider.dart';

class QuizRepository {
  final QuizProvider provider;
  QuizRepository(this.provider);

  getQuestions() async {
    var response = await provider.getQuestions();
    ClanQuizModel model =
        ClanQuizModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return model;
  }

  startQuiz() async {
    var response = await provider.startQuiz();
    return response;
  }

  sendAnswer(int questionId, String letter) async {
    var response = await provider.sendAnswer(questionId, letter);
    CorrectAnswerModel model = CorrectAnswerModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    return model;
  }
}
