import 'dart:convert';

import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/data/provider/extract_provider/extract_provider.dart';
import 'package:flutter/material.dart';

class ExtractRepository {
  final ExtractProvider provider;
  ExtractRepository({required this.provider});

  Future getStandardTransactions() async {
    try {
      var response = await provider.getStandardTransactions();
      return ExtractModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }

  Future getCustomFilteredTransactions(
      String initialDate, String finalDate) async {
    try {
      var response = await provider.getFilteredTransactions(
          initialData: initialDate, finalDate: finalDate);
      return ExtractModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      throw e;
    }
  }
}
