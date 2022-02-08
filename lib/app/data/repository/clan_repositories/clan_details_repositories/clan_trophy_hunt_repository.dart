import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_trophy_hunt_provider.dart';

class ClanTrophyHuntRepository {
  final ClanTrophyHuntProvider provider;
  ClanTrophyHuntRepository(this.provider);

  getModel() async {
    var response = await provider.getModel();
    TrophyHuntModel model =
        TrophyHuntModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return model;
  }

  postBag(TrophyHuntModelRequest request) async {
    var response = await provider.postBag(request);
    return response;
  }
}
