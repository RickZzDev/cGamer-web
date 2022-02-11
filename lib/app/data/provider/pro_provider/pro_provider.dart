import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/extract_endpoints/extract_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/prime_endpoints/prime_endpoint.dart';
import 'package:flutter/material.dart';

class ProProvider {
  final Requester requester;

  ProProvider({required this.requester});

  Future<dynamic> confirmIOSPrime(String purchaseId) async {
    var response = await requester.put(
        url: PrimeEndpoints.confirmIOSPurchase(purchaseId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> confirmAndroidPrime(String purchaseId) async {
    var response = await requester.put(
        url: PrimeEndpoints.confirmAndroidPurchase(purchaseId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getBenefits() async {
    var response = await requester.fetch(
        url: PrimeEndpoints.getBenefits,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getInfo() async {
    var response = await requester.fetch(
        url: PrimeEndpoints.getInfo,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> rescueReward(int idReward) async {
    var response = await requester.post(
        url: PrimeEndpoints.rescueReward(idReward),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> saveDiscordId(String id) async {
    var response = await requester.put(
        url: PrimeEndpoints.saveDiscordId(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
