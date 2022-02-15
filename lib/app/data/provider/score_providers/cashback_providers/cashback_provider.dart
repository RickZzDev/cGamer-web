import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/exclusivity_endpoints/cashback_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';

class CashbackProvider {
  final Requester httpClient;

  CashbackProvider({required this.httpClient});

  Future<dynamic> getCashbackProducts() async {
    var response = await new Requester().fetch(
        url: CashbackEndpoints.cashbackUrl,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
