import 'dart:convert';

import 'package:cGamer/app/data/models/play_to_win_models/play_to_win_model.dart';
import 'package:cGamer/app/data/provider/play_to_win_providers/play_to_win_provider.dart';
import 'package:http/http.dart';

class PlayToWinRepository {
  final PlayToWinProvider provider;
  PlayToWinRepository(this.provider);

  Future<List<PlayToWinGame>?> getPlayToWinGames() async {
    try {
      Response response = await provider.getPlayToWinGames();
      PlayToWinModel model =
          PlayToWinModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return model.games;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getAccountDetail(int id) async {
    try {
      Response response = await provider.getAccountDetail(id);
      GameInfo model =
          GameInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> syncAccount(int id) async {
    try {
      Response response = await provider.syncAccount(id);
      GameInfo model =
          GameInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> rescuePoints(int id) async {
    try {
      Response response = await provider.rescuePoints(id);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw e;
    }
  }
}
