import 'dart:convert';

import 'package:cGamer/app/data/models/play_to_win_models/play_to_win_model.dart';
import 'package:cGamer/app/data/provider/play_to_win_providers/lol_providers/lol_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
class LolRepository {
  final LolProvider provider;
  LolRepository({required this.provider});

  Future<dynamic> connectAccount(int gameId, String gameNick) async {
    try {
      var response = await provider.connectAccount(gameId, gameNick);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
