import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:flutter/material.dart';

class CreateNewClanProvider {
  final Requester requester;

  CreateNewClanProvider({required this.requester});

  Future<dynamic> postNewClan(Map<String, dynamic> body) async {
    var response = await requester.post(
        url: ClanEndpoints.postNewClan,
        body: body,
        header: await new Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getEmblems() async {
    var response = await requester.fetch(
        url: ClanEndpoints.getEmblems,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getProfile() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
