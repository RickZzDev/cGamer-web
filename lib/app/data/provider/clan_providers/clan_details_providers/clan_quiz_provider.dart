import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';

class QuizProvider {
  final Requester requester;

  QuizProvider(this.requester);

  getQuestions() async {
    var response = await requester.fetch(
        url: ClanEndpoints.getQuestions,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  startQuiz() async {
    var response = await requester.put(
        url: ClanEndpoints.startQuiz,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  sendAnswer(int questionId, String letter) async {
    var response = await requester.post(
        url: ClanEndpoints.sendAnswer(questionId),
        header: await Headers().getAuthenticatedHeader(),
        body: {'letter': letter});
    return response;
  }
}
