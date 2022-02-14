import 'dart:convert';

import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/coint_wallet_endpoints/coin_wallet_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/extract_endpoints/extract_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/prime_endpoints/prime_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CoinWalletProvider {
  final Requester requester;

  CoinWalletProvider({required this.requester});

  Future<dynamic> getBenefits() async {
    var response = await requester.fetch(
        url: PrimeEndpoints.getBenefits,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<Response> getMafaBalance() async {
    try {
      Response response = await requester.fetch(
        url: CoinWalletEndpoints.balance,
        header: await Headers().getAuthenticatedHeader(),
      );
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> getLastMoviments() async {
    try {
      Response response = await requester.fetch(
        url: CoinWalletEndpoints.transaction,
        header: await Headers().getAuthenticatedHeader(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchUser(String userName) async {
    try {
      Response response = await requester.fetch(
        ///TODO externalziar para o local certo dos endpoints
        url: CoinWalletEndpoints.transaction,
        header: await Headers().getAuthenticatedHeader(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> payWithPix(PayWithPixRequest request) async {
    try {
      Response response = await requester.postV2(
        body: request.toJson(),
        url: CoinWalletEndpoints.rechargeWithPix,
        header: await Headers().getAuthenticatedHeader(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> confirmPix(String orderId) async {
    try {
      Response response = await requester.fetch(
        url: CoinWalletEndpoints.exchange(orderId),
        header: await Headers().getAuthenticatedHeader(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
