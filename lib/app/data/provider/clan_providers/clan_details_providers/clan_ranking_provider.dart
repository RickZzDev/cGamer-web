import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:flutter/foundation.dart';

class ClanRankingProvider {
  final Requester requester;
  ClanRankingProvider({required this.requester});

  Future<dynamic> getRankingOfClans() async {
    var response = await requester.fetch(
        url: ClanEndpoints.rankingClans,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getRankingOfMembers() async {
    var response = await requester.fetch(
        url: ClanEndpoints.rankingMembers,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getClanInfo() async {
    var response = await requester.fetch(
      url: ClanEndpoints.clanInfo,
      header: await Headers().getAuthenticatedHeader(),
    );

    return response;
  }
}
