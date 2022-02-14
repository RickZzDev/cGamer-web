import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/wallet_endpoints/virtual_card_endpoints.dart';

class CardExtractProvider {
  final Requester requester;
  CardExtractProvider(this.requester);

  Future<dynamic> getCardExtract() async {
    try {
      var response = await requester.fetch(
          url: VirtualCardsEndpoints.getVirtualCardTransactions(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> getCustomCardExtract(
      String initialDate, String finalDate) async {
    Map<String, String> _params = {
      'startDate': initialDate,
      'finalDate': finalDate
    };

    try {
      var response = await requester.fetch(
          header: await Headers().getAuthenticatedHeader(),
          url: VirtualCardsEndpoints.urlFilteredTransactions(),
          params: _params);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
