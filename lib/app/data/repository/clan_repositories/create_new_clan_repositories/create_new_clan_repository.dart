import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/data/provider/clan_providers/create_new_clan_providers/create_new_clan_provider.dart';
import 'package:cGamer/app/ui/components/clan_components/create_new_clan_components/choose_emblem/emblem_grid_item.dart';
import 'package:flutter/foundation.dart';

class CreateNewClanRepository {
  final CreateNewClanProvider provider;

  CreateNewClanRepository({required this.provider});

  Future postNewClan(Map<String, dynamic> body) async {
    var response = await provider.postNewClan(body);
    return response;
  }

  Future<ClanEmblemModel> getEmblems() async {
    var response = await provider.getEmblems();

    return ClanEmblemModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

  getProfile() async {
    return await provider.getProfile();
  }
}
