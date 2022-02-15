import 'dart:async';
import 'dart:math';

import 'package:cGamer/app/data/models/clans_models/clan_roulette_models.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_roulette_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClanRouletteController extends GetxController {
  final ClanRouletteRepository repository;
  ClanRouletteController(this.repository);

  var isAnimating = false.obs;
  var btnDuplicateIsEnabled = true.obs;
  var hasMultiplied = false.obs;

  var hasPlayed = false.obs;
  var loading = false.obs;
  var randomIndex = -1;
  /* Roulette Streams */
  StreamController<int> roulleteController = StreamController<int>();
  Sink<int> get input => roulleteController.sink;
  Stream<int> get output => roulleteController.stream;
  /* */

  late dynamic showMessage;
  late var model = ClanRouletteModel().obs;

  var rouletteValuesHasLoaded = false.obs;

  @override
  void onInit() async {
    isAnimating.listen((p0) {
      p0 ? print('animating') : print('animation stoped');
    });
    rouletteValuesHasLoaded.value = await getRouletteItems();
    super.onInit();
  }

  bool get isLoading => rouletteValuesHasLoaded.value;

  @override
  void onClose() {
    roulleteController.close();
    super.onClose();
  }

  void animationStarted() {
    !isAnimating.value ? isAnimating.value = true : DoNothingAction();
    btnDuplicateIsEnabled.value = false;
    playRoulette();
  }

  void animationEnded() {
    if (isAnimating.value) {
      isAnimating.value = !isAnimating.value;
    }
    SnackBarUtils.showSnackBar(
        color: primaryColor,
        desc:
            'Você ganhou ${this.model.value.values[randomIndex]} troféu(s) para o clã!',
        title: 'Parabéns');
  }

  void spinRoulette() {
    if (hasPlayed.value) {
      SnackBarUtils.showSnackBar(
          color: Colors.orange[400],
          desc: 'Você já fez sua jogada, volte e aguarde para jogar novamente.',
          title: 'Atenção');
      return;
    }
    hasPlayed.value = true;
    if (!isAnimating.value) {
      final random = Random();
      var randomNumber = random.nextInt(11);
      randomIndex = randomNumber;
      input.add(randomNumber);
    }
  }

  Future<bool> playRoulette() async {
    //loading.value = true;
    PlayRouletteRequestModel request = PlayRouletteRequestModel();
    request.value = this.model.value.values[randomIndex];
    request.payPoints = hasMultiplied.value;
    try {
      var response = await repository.playRoulette(request);
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        hasPlayed.value = false;
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
      }

      hasPlayed.value = true;
      DartNotificationCenter.post(channel: 'refreshCla');
      return true;
    } catch (e) {
      //loading.value = false;
      hasPlayed.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
    }
  }

  Future<bool> getRouletteItems() async {
    try {
      var response = await repository.getRouletteItems();
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
      }
      this.model.value = response;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      return false;
    }
  }

  void multiplyValue() {
    if (isAnimating.value) {
      SnackBarUtils.showSnackBar(
          desc: "Você precisa ativar essa função antes de rodar a roleta.",
          title: "Atenção");
      return;
    }

    if (!btnDuplicateIsEnabled.value) {
      if (hasPlayed.value) {
        SnackBarUtils.showSnackBar(
            color: Colors.orange[400],
            desc:
                'Você já fez sua jogada, volte e aguarde para jogar novamente.',
            title: 'Atenção');
        return;
      } else {
        SnackBarUtils.showSnackBar(
            color: Colors.orange[400],
            desc: 'Você já duplicou suas chances, rode a roleta e boa sorte!',
            title: 'Atenção');
        return;
      }
    }
    if (hasPlayed.value) {
      SnackBarUtils.showSnackBar(
          color: Colors.orange[400],
          desc:
              'Você já fez sua jogada, somente é possível duplicar antes de jogar.',
          title: 'Atenção');
      return;
    }

    btnDuplicateIsEnabled.value = false;
    hasMultiplied.value = true;

    List<String> multipliedValues = [];

    this.model.value.values.forEach((element) {
      int intValue = int.parse(element);

      multipliedValues.add((intValue * 2).toString());
    });

    this.model.value.values = multipliedValues;
    model.refresh();
  }
}
