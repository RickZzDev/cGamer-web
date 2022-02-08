import 'dart:async';

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

class SearchPlayerController extends GetxController {
  final PlayTogetherRepository repository;
  SearchPlayerController({required this.repository});

  var loading = false.obs;
  var isCancelled = false.obs;
  var platformId = 0;
  var gameId = 0;
  RxString gameImage = "".obs;
  String from = "";

  SearchFastMatchModel? searchFastmodel;
  NearbyPlayersModel? nearbyPlayersModel;
  RxList<PlayTogetherGame>? gamesPlatform = RxList();

  /*GEO */
  Position? position;
  LocationUtils location = new LocationUtils();
  /* */

  @override
  void onInit() async {
    initSetup();
    super.onInit();
  }

  Future<void> searchFastMatch() async {
    try {
      var response = await repository.searchFastMatch(platformId, gameId);

      if (!ExceptionUtils.verifyIfIsException(response)) {
        this.searchFastmodel = response;

        Timer(Duration(seconds: 3), () {
          if (isCancelled.value) {
            return;
          }
          // Get.back();

          Get.toNamed(Routes.FOUND_PLAYER, arguments: {
            'model': searchFastmodel,
            'platformId': platformId,
            'gameId': gameId,
            'gameImage': gameImage.value,
            'from': from
          });
        });
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível concluír a busca, volte e tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> searchNearBy() async {
    try {
      var response = await repository.searchNearBy(platformId, gameId, 50.0);

      if (!ExceptionUtils.verifyIfIsException(response)) {
        this.nearbyPlayersModel = response;

        Timer(Duration(seconds: 3), () {
          if (isCancelled.value) {
            return;
          }

          Get.toNamed(
            Routes.NEARBY_PLAYERS,
            arguments: {
              'model': nearbyPlayersModel,
              'platformId': platformId,
              'gameId': gameId,
              'gameImage': gameImage.value,
              'from': from
            },
          );
        });
        return;
      }

      SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      return;
    } catch (e) {
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
    this.searchFastmodel = Get.arguments['model'];

    if (this.from == "FASTMATCH") {
      await searchFastMatch();
    } else {
      await searchNearBy();
    }
  }
}
