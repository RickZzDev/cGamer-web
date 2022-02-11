import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/data/models/home_models/missions_model.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:cGamer/app/data/repository/profile_repositories/my_progress_repository/my_progress_repository.dart';

class MyProgressController extends GetxController {
  final MyProgressRepository repository;
  final HomeRepository homeRepository;
  MyProgressController(
      {required this.repository, required this.homeRepository});

  ScrollController scrollController = ScrollController();

  Rx<Future<bool>> hasCompletedLevelsRequest = Future.value(false).obs;
  Rx<Future<bool>> hasCompletedInfoRequest = Future.value(false).obs;
  Rx<LevelsModel> levelsResult = LevelsModel().obs;
  Rx<MissionsModel> missionsResult = MissionsModel().obs;
  Rx<Level> infoResult = Level().obs;

  final allComplete = false.obs;

  changeAllComplete({bool valueAllComplete = true}) =>
      this.allComplete.value = valueAllComplete;

  @override
  void onReady() async {
    hasCompletedLevelsRequest.value = getLevels();
    hasCompletedInfoRequest.value = getInfo();

    await Future.delayed(Duration(seconds: 1));
    await scrollController.animateTo(1500,
        duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    super.onReady();
  }

  Future<bool> getLevels() async {
    var response = await repository.getLevels();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      levelsResult.value = LevelsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  Future<bool?> getMissions() async {
    var response = await homeRepository.getMissions();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return null;
    } else {
      missionsResult.value = MissionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  Future<bool> getInfo() async {
    var response = await repository.getMyProgressInfo();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      infoResult.value = Level.fromJson(
        json.decode(utf8.decode(response.bodyBytes))['customerLevel'],
      );
      return true;
    }
  }

  double getPercentProgressBar() {
    if (infoResult.value != null && infoResult.value.nextLevelPoints != null) {
      double nextPoints = infoResult.value.nextLevelPoints ?? 0.0;
      double customerPoints = infoResult.value.customerPoints ?? 0.0;
      double points = customerPoints > nextPoints ? nextPoints : customerPoints;
      return ((100 * points) / nextPoints) / 100;
    } else {
      return 1.0;
    }
  }
}
