import 'dart:convert';

import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/data/provider/score_providers/cashback_providers/cashback_provider.dart';
import 'package:flutter/material.dart';

class CashbackRepository {
  final CashbackProvider provider;
  CashbackRepository({required this.provider});

  Future<CashBackModel> getCashBackProducts() async {
    try {
      var response = await provider.getCashbackProducts();

      CashBackModel model =
          CashBackModel.fromMap(json.decode(utf8.decode(response.bodyBytes)));
      return model;
    } catch (error) {
      throw error;
    }
  }
}
