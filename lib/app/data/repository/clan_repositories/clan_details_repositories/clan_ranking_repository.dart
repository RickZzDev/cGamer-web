import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_ranking_model.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_details_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_ranking_provider.dart';
import 'package:flutter/material.dart';

class ClanRankingRepository {
  final ClanRankingProvider provider;
  ClanRankingRepository({required this.provider});

  Future<ClanRankingModel> getRankingOfClans() async {
    try {
      var response = await provider.getRankingOfClans();
      return ClanRankingModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }

  Future<MembersRankingModel> getRankingOfMembers() async {
    try {
      var response = await provider.getRankingOfMembers();
      return MembersRankingModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }

  Future<ClanInfoModel> getClanInfo() async {
    try {
      var response = await provider.getClanInfo();
      return ClanInfoModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }
}
