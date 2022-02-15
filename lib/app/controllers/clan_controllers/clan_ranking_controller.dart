import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_ranking_model.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/data/models/score_models/score_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_ranking_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:intl/intl.dart';

class ClanRankingController extends GetxController {
  final ClanRankingRepository repository;

  ClanRankingController({required this.repository});

  Rx<ClanRankingModel> rankingModelResult = ClanRankingModel().obs;
  Rx<MembersRankingModel> membersModelResult = MembersRankingModel().obs;

  final hasCompletedRankingResult = false.obs;
  bool get loading => !rankingHasLoaded.value && !userHasClanLoaded.value;
  var rankingHasLoaded = false.obs;
  var rankingMembersHasLoaded = false.obs;
  var userHasClanLoaded = false.obs;

  ClanInfoModel? clanInfoModel;
  List<Tab>? tabs;

  @override
  void onInit() async {
    tabs = [
      Tab(
        child: Text(
          'Clãns',
          style: textStyle.copyWith(fontSize: 16),
        ),
      ),
      Tab(
        child: Text(
          'Membros',
          style: textStyle.copyWith(fontSize: 16),
        ),
      )
    ];

    rankingHasLoaded.value = await getRanking();
    userHasClanLoaded.value = await userHasClan();
    rankingMembersHasLoaded.value = await getMembersRanking();
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedRankingResult.value = await getRanking();
    super.onReady();
  }

  Future<void> onRefreshRankingView() async {
    hasCompletedRankingResult.value = await getRanking();
  }

  Future<void> onRefreshMembersRankingView() async {
    rankingMembersHasLoaded.value = await getMembersRanking();
  }

  int? getTimeLeft(String? date) {
    DateTime dateFinishSeason =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date ?? "");
    return dateFinishSeason.millisecondsSinceEpoch;
  }

  Future<bool> getRanking() async {
    var response = await repository.getRankingOfClans();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      rankingModelResult.value = response;
      return true;
    }
  }

  Future<bool> getMembersRanking() async {
    var response = await repository.getRankingOfMembers();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      membersModelResult.value = response;
      return true;
    }
  }

  Future<bool> userHasClan() async {
    try {
      dynamic response = await repository.getClanInfo();

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      }
      this.clanInfoModel = response;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
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
