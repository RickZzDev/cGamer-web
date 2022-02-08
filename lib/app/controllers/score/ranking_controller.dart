import 'dart:convert';

import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/data/models/score_models/score_model.dart';
import 'package:cGamer/app/data/repository/score_repository/score_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class RankingController extends GetxController {
  final ScoreRepository repository;

  RankingController({required this.repository});

  Rx<RankingModel> rankingModelResult = RankingModel().obs;
  Rx<ScoreModel> scoreModelResult = ScoreModel().obs;

  final hasCompletedRankingResult = false.obs;
  final hasCompletedScoreResult = false.obs;
  final loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedRankingResult.value = await getRanking();
    super.onReady();
  }

//356.5
  Future<void> onRefreshRankingView() async {
    hasCompletedRankingResult.value = await getRanking();
    hasCompletedScoreResult.value = await getScore();
  }

  Future<bool> getScore() async {
    var response = await repository.getScore();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      scoreModelResult.value = ScoreModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      scoreModelResult.refresh();
      return true;
    }
  }

  Future<bool> getRanking() async {
    loading.value = true;
    var response = await repository.getRanking();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      rankingModelResult.value = RankingModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  void showAlertInfo(String message) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: textStyle.copyWith(
            color: secondaryColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text(message, style: textStyle.copyWith(color: secondaryColor)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
