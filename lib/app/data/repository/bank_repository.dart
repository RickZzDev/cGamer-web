import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/home_models/avatar_model.dart';
import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/data/models/profile_model/games_model/games_model.dart';
import 'package:cGamer/app/data/provider/bank_provider/bank_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';

class BankRepository {
  final BankApiClient apiClient;

  BankRepository({required this.apiClient});

  dynamic getStatusRegister() async {
    return await apiClient.getStatusRegister();
  }

  getHomeStats() async {
    return await apiClient.getHomeStats();
  }

  getProfile() async {
    return await apiClient.getProfile();
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

  Future<AvatarModel> getAvatars() async {
    try {
      Response response = await apiClient.getAvatars();
      AvatarModel avatarModel = AvatarModel.fromJson(
        json.decode(response.body),
      );
      return avatarModel;
    } catch (e) {
      throw e;
    }
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
