import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_machine_trophy_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_trophy_hunt_provider.dart';

class JogoVelhaRepository {
  final JogoVelhaProvider provider;
  JogoVelhaRepository(this.provider);

  getModel() async {
    var response = await provider.getModel();
    TrophyHuntModel model =
        TrophyHuntModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return model;
  }

  postJogoDaVelha(bool hasWon) async {
    var response = await provider.postJogoDaVelha(hasWon);
    return response;
  }

  postBag(TrophyHuntModelRequest request) async {
    var response = await provider.postBag(request);
    return response;
  }
}
