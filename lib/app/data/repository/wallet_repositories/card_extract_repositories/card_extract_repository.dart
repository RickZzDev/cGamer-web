import 'dart:convert';

import 'package:cGamer/app/data/models/wallet_models/virtual_card_transactions.dart';
import 'package:cGamer/app/data/provider/wallet_providers/card_extract_providers/card_extract_provider.dart';

class CardExtractRepository {
  final CardExtractProvider provider;
  CardExtractRepository(this.provider);

  Future<dynamic> getCardExtract() async {
    try {
      var response = await provider.getCardExtract();
      return VirtualCardTransactionsModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }

  Future<VirtualCardTransactionsModel> getCustomCardExtract(
      String initialDate, String finalDate) async {
    try {
      var response =
          await provider.getCustomCardExtract(initialDate, finalDate);

      return VirtualCardTransactionsModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      throw e;
    }
  }
}
