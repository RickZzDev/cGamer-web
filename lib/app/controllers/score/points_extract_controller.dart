import 'dart:convert';

import 'package:cGamer/app/data/models/score_models/points_transaction_model.dart';
import 'package:cGamer/app/data/repository/score_repository/score_repository.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/points_transactions_list.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointsExtractController extends GetxController {
  final ScoreRepository repository;

  PointsExtractController({required this.repository});

  Rx<PointsTransactionModel> transactionsModelResult =
      PointsTransactionModel().obs;

  final hasCompletedTransactionsResult = false.obs;
  final loading = false.obs;
  final indexTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  Future<void> refresh() async {
    hasCompletedTransactionsResult.value = await getTransactions();
  }

  Future<bool> getTransactions() async {
    loading.value = true;
    var response = await repository.getTransactions();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      transactionsModelResult.value = PointsTransactionModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }
}
