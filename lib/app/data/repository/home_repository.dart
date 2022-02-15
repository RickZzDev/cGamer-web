import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/home_models/avatar_model.dart';
import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/data/models/home_models/podcast_model.dart';
import 'package:cGamer/app/data/models/profile_model/games_model/games_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';

class HomeRepository {
  final HomeApiClient apiClient;

  HomeRepository({required this.apiClient});

  dynamic getStatusRegister() async {
    return await apiClient.getStatusRegister();
  }

  getHomeStats() async {
    return await apiClient.getHomeStats();
  }

  getMissions() async {
    return await apiClient.getMissions();
  }

  getBalance() async {
    return await apiClient.getBalance();
  }

  Future<ExtractModel> getHomeExtract(
      {required int size, required initialDate, required finalDate}) async {
    try {
      var response = await apiClient.getHomeExtract(
          size: size, initialDate: initialDate, finalDate: finalDate);
      return ExtractModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<ClanInfoModel> getClanInfo() async {
    try {
      var response = await apiClient.getClanInfo();
      return ClanInfoModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<PodcastModel> getPodcasts() async {
    try {
      var response = await apiClient.getPodcasts();
      return PodcastModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<ProfileGamesModel> getGames() async {
    try {
      Response response = await apiClient.getGames();
      return ProfileGamesModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<ProfileGamesModel> getSelectedGames() async {
    try {
      Response response = await apiClient.getSelectedGames();
      return ProfileGamesModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw e;
    }
  }

  Future sendGames(List<int> _body) async {
    try {
      Response response = await apiClient.sendGames(_body);
      return response;
    } catch (e) {
      return throw e;
    }
  }

  Future<AvatarModel> getAvatars() async {
    try {
      dynamic response = await apiClient.getAvatars();
      AvatarModel avatarModel = AvatarModel.fromJson(
        json.decode(response.body),
      );
      return avatarModel;
    } catch (e) {
      throw e;
    }
  }

  getRanking() async {
    return await apiClient.getRanking();
  }

  sendAvatar(int _index) async {
    try {
      Response response = await apiClient.sendAvatars({"id": _index});

      return response;
    } catch (e) {
      throw e;
    }
  }
}
