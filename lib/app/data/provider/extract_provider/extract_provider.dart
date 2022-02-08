import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/extract_endpoints/extract_endpoints.dart';
import 'package:flutter/material.dart';

class ExtractProvider {
  final Requester httpClient;

  ExtractProvider({required this.httpClient});

  Future getStandardTransactions() async {
    try {
      var response = await httpClient.fetch(
          url: ExtractEndpoints.urlStandardTransactions,
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future getFilteredTransactions(
      {String? initialData, String? finalDate}) async {
    try {
      var response = await httpClient.fetch(
          url: ExtractEndpoints.urlFilteredTransactions(
              initialData ?? "", finalDate ?? ""),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      throw e;
    }
  }
}
