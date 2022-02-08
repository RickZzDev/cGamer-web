import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';
import 'package:flutter/foundation.dart';

class ClanProvider {
  final Requester requester;
  ClanProvider({required this.requester});

  Future<dynamic> getClansList(String clanName) async {
    Map<String, String> _params = {'name': clanName};
    var response = await requester.fetch(
        url: ClanEndpoints.getClansUrl(),
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }
}
