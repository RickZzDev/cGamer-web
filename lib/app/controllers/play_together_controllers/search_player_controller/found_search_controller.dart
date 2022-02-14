import 'dart:async';

import 'package:cGamer/app/data/models/play_together_models/invite_model.dart';
import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/play_together_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/location_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class FoundSearchController extends GetxController {
  final PlayTogetherRepository repository;
  FoundSearchController({required this.repository});

  var loading = false.obs;
  var inviteSuccessful = false.obs;

  var platformId = 0;
  var gameId = 0;
  RxString gameImage = "".obs;
  String from = "";

  SearchFastMatchModel? searchFastmodel;

  NearbyPlayer? nearByPlayer;
  RxList<PlayTogetherGame>? gamesPlatform = RxList();

  @override
  void onInit() async {
    initSetup();
    super.onInit();
  }

  Future<void> sendInvite(bool isFastMatch) async {
    loading.value = true;
    try {
      PlayTogetherInviteRequest requestModel = PlayTogetherInviteRequest();
      requestModel.customerId = isFastMatch
          ? searchFastmodel?.playerMatch?.customerId ?? 0
          : nearByPlayer?.customerId ?? 0;
      requestModel.from = from;
      requestModel.gameId = gameId;
      requestModel.platformId = platformId;
      var response = await repository.sendInvite(requestModel);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        inviteSuccessful.value = true;
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível concluír a busca, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  void initSetup() async {
    this.platformId = Get.arguments['platformId'];
    this.gameId = Get.arguments['gameId'];
    this.gameImage.value = Get.arguments['gameImage'];
    this.from = Get.arguments['from'];
    if (this.from == "FASTMATCH") {
      this.searchFastmodel = Get.arguments['model'];
    } else {
      this.nearByPlayer = Get.arguments['model'];
    }
  }
}
