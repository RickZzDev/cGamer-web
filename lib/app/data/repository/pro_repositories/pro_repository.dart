import 'dart:convert';

import 'package:cGamer/app/data/models/prime_models/prime_model.dart';
import 'package:cGamer/app/data/provider/pro_provider/pro_provider.dart';
import 'package:http/http.dart';

class ProRepository {
  final ProProvider provider;
  ProRepository({required this.provider});

  Future<dynamic> confirmIOSPrime(String purchaseId) async {
    try {
      dynamic response = await provider.confirmIOSPrime(purchaseId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> confirmAndroidPrime(String purchaseId) async {
    try {
      dynamic response = await provider.confirmAndroidPrime(purchaseId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getBenefits() async {
    try {
      Response response = await provider.getBenefits();
      PrimeBenefitsModel model = PrimeBenefitsModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));

      //  dynamic response = await provider.getBenefits();
      return model;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> getInfo() async {
    try {
      Response response = await provider.getInfo();
      PrimeInfoModel model =
          PrimeInfoModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      //  dynamic response = await provider.getBenefits();
      return model;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> rescueReward(int idReward) async {
    try {
      dynamic response = await provider.rescueReward(idReward);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> saveDiscordId(String id) async {
    try {
      dynamic response = await provider.saveDiscordId(id);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
