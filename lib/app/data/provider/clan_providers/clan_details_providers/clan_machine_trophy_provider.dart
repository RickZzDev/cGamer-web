import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';

class JogoVelhaProvider {
  final Requester requester;

  JogoVelhaProvider(this.requester);

  getModel() async {
    var response = await requester.fetch(
        url: ClanEndpoints.hunterTrophy,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  postJogoDaVelha(bool hasWon) async {
    var response = await requester.post(
        url: ClanEndpoints.jogoVelha,
        header: await Headers().getAuthenticatedHeader(),
        body: {"win": hasWon});
    return response;
  }

  postBag(TrophyHuntModelRequest request) async {
    var response = await requester.post(
        url: ClanEndpoints.hunterTrophy,
        header: await Headers().getAuthenticatedHeader(),
        body: request.toJson());
    return response;
  }
}
