import 'dart:convert';

import 'package:cGamer/app/data/models/play_together_models/add_game_model.dart';
import 'package:cGamer/app/data/models/play_together_models/invite_model.dart';
import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';
import 'package:cGamer/app/data/provider/play_together_providers/play_together_provider.dart';
import 'package:http/http.dart';

class PlayTogetherRepository {
  final PlayTogetherProvider provider;
  PlayTogetherRepository(this.provider);

  Future<PlayTogetherModel> getInfo() async {
    try {
      Response response = await provider.getInfo();
      PlayTogetherModel model = PlayTogetherModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeBeFound(bool beFound) async {
    try {
      Response response = await provider.changeBeFound(beFound);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> putLocation(double latitude, double longitude) async {
    try {
      dynamic response = await provider.putLocation(latitude, longitude);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<AddGameModel> getGamesByPlatform(int platformId) async {
    try {
      Response response = await provider.getGamesByPlatform(platformId);
      AddGameModel model =
          AddGameModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editAGame(
      {required String platformId,
      required String gameId,
      required String nickName}) async {
    var response = await provider.editAGame(
        platformId: platformId, gameId: gameId, nickName: nickName);
    return response;
  }

  Future<dynamic> removeAGame({
    required String platformId,
    required String gameId,
  }) async {
    var response =
        await provider.removeAGame(platformId: platformId, gameId: gameId);
    return response;
  }

  Future<dynamic> searchFastMatch(int platformId, int gameId) async {
    try {
      dynamic response = await provider.searchFastMatch(platformId, gameId);
      SearchFastMatchModel model = SearchFastMatchModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> searchNearBy(
      int platformId, int gameId, double radius) async {
    try {
      dynamic response =
          await provider.searchNearBy(platformId, gameId, radius);
      NearbyPlayersModel model = NearbyPlayersModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendInvite(PlayTogetherInviteRequest request) async {
    try {
      dynamic response = await provider.sendInvite(request);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
