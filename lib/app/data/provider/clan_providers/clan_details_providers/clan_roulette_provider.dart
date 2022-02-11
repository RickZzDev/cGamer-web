import 'package:cGamer/app/data/models/clans_models/clan_roulette_models.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';

class ClanRouletteProvider {
  final Requester requester;
  ClanRouletteProvider(this.requester);

  getRouletteItems() async {
    var response = await requester.fetch(
        url: ClanEndpoints.getRouletteItems,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  playRoulette(PlayRouletteRequestModel model) async {
    var response = await requester.post(
        url: ClanEndpoints.playRoulette,
        body: model.toJson(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
