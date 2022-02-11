import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_roulette_models.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_roulette_provider.dart';

class ClanRouletteRepository {
  final ClanRouletteProvider provider;
  ClanRouletteRepository(this.provider);

  Future<ClanRouletteModel> getRouletteItems() async {
    var result = await provider.getRouletteItems();

    ClanRouletteModel response =
        ClanRouletteModel.fromJson(json.decode(utf8.decode(result.bodyBytes)));

    return response;
  }

  Future<dynamic> playRoulette(PlayRouletteRequestModel model) async {
    var response = await provider.playRoulette(model);
    return response;
  }
  
}
