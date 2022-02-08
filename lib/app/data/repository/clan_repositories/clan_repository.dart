import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_provider.dart';
import 'package:flutter/material.dart';

class ClanRepository {
  final ClanProvider provider;

  ClanRepository({required this.provider});

  Future<dynamic> getClansList(String clanName) async {
    try {
      var response = await provider.getClansList(clanName);
      return ClanPageModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }
}
