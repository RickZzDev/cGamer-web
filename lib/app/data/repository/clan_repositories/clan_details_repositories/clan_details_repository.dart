import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/data/models/clans_models/clan_play_win_trophy_model.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_details_provider.dart';
import 'package:flutter/material.dart';

class ClanDetailsRepository {
  final ClanDetailsProvider provider;
  ClanDetailsRepository({required this.provider});

  Future<ClanDetailsModel> getClanDetails(String id) async {
    try {
      var response = await provider.getClanDetails(id);
      return ClanDetailsModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> requestEntry(String id) async {
    try {
      var response = await provider.requestEntry(id);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getRequestEntry(String id) async {
    try {
      var response = await provider.getRequestEntry(id);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> approveMember(String id, String customerId) async {
    try {
      var response = await provider.approveMember(id, customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> promoveMember(
      String id, String customerId, String role) async {
    try {
      var response = await provider.promoveMember(role, id, customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> removeMember(String id, String customerId) async {
    try {
      var response = await provider.removeMember(id, customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> reproveMember(String id, String customerId) async {
    try {
      var response = await provider.reproveMember(id, customerId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> updateCla(String id, CreateClanModel model) async {
    try {
      var response = await provider.updateCla(id, model);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> leftCla(String id) async {
    try {
      var response = await provider.leftCla(id);
      return response;
    } catch (e) {
      throw e;
    }
  }

  getProfile() async {
    return await provider.getProfile();
  }

  saveFirebaseId(String firebaseId) async {
    return await provider.saveFirebaseId(firebaseId);
  }

  Future<ClanEmblemModel> getEmblems() async {
    var response = await provider.getEmblems();

    return ClanEmblemModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<PlayWinTrophyModel> getPlayWinTrophys() async {
    var response = await provider.getPlayWinTrophys();

    return PlayWinTrophyModel.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<dynamic> rescueTrophy() async {
    var response = await provider.rescueTrophy();
    return response;
  }
}
