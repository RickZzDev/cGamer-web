import 'dart:math';

import 'package:cGamer/app/data/models/clans_models/clan_trophy_hunt_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_machine_trophy_repository.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_trophy_hunt_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:get/get.dart';

class JogoVelhaController extends GetxController {
  final JogoVelhaRepository repository;

  JogoVelhaController(this.repository);

  late TrophyHuntModel model;

  var btnDuplicateIsEnabled = true.obs;
  var bagIsEquiped = false.obs;
  var modelHasLoaded = false.obs;
  var postBagHasLoaded = true.obs;

  var loading = false.obs;

  RxList<List> matrix = RxList<List>();
  String _lastChar = 'O';
  int totalPlays = 0;
  var isWinner = false.obs;
  var hasWinner = false.obs;
  var isVelha = false.obs;
  var titleConvesation = 'Vamos jogar?'.obs;
  var descConversation = 'É a sua vez!'.obs;
  var botIsPlaying = false.obs;

  _initMatrix() {
    matrix.value = List.filled(3, []);
    for (var row = 0; row < matrix.length; row++) {
      matrix[row] = List.filled(3, []);
      for (var column = 0; column < matrix.length; column++) {
        matrix[row][column] = ' ';
      }
    }
  }

  void limpaTudo() {
    _initMatrix();
  }

  checkWinner(int x, int y) {
    if (hasWinner.value) {
      return;
    }

    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (int i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) col++;

      if (matrix[i][y] == player) row++;

      if (matrix[i][i] == player) diag++;

      if (matrix[i][n - i] == player) rdiag++;
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      print('$player Venceu');
      hasWinner.value = true;
      if (player == 'X') {
        isWinner.value = true;
        titleConvesation.value = "Ahh que pena, perdi :(";
        descConversation.value = "Parabéns, você mandou bem!";

        postJogoDaVelha(true);
      } else {
        titleConvesation.value = "Iuppiiiii! Ganhei!";
        descConversation.value = "Não foi dessa vez! Volte depois!";
        postJogoDaVelha(false);
      }
    } else {
      if (totalPlays == 9) {
        if (hasWinner.value || isVelha.value) {
          return;
        } else {
          isVelha.value = true;
          titleConvesation.value = "Poxa u.u";
          descConversation.value = "Deu VELHA!";
          postJogoDaVelha(false);
        }
      }
    }
  }

  changeMatrixField(int row, int column, bool isBot) async {
    if (totalPlays == 9) {
      if (hasWinner.value) {
        return;
      } else {
        titleConvesation.value = "Poxa u.u";
        descConversation.value = "Deu VELHA!";
      }
    }

    if (matrix[row][column] == ' ') {
      if (_lastChar == 'O')
        matrix[row][column] = 'X';
      else
        matrix[row][column] = 'O';

      _lastChar = matrix[row][column];

      matrix.refresh();
      totalPlays = totalPlays + 1;
      if (!isBot && !hasWinner.value) {
        titleConvesation.value = "Será que vou ganhar?";
        descConversation.value = "É a minha vez :)";
        botIsPlaying.value = true;
        await Future.delayed(Duration(seconds: 1));
        botIsPlaying.value = false;
        titleConvesation.value = "Pode jogar novamente!";
        descConversation.value = "É a sua vez!";
        int x = Random().nextInt(3);
        int y = Random().nextInt(3);

        changeMatrixField(x, y, true);
        checkWinner(x, y);
      }
    } else {
      if (isBot && !hasWinner.value) {
        titleConvesation.value = "Será que vou ganhar?";
        descConversation.value = "É a minha vez :)";
        botIsPlaying.value = true;
        await Future.delayed(Duration(seconds: 1));
        botIsPlaying.value = false;
        titleConvesation.value = "Pode jogar novamente!";
        descConversation.value = "É a sua vez!";
        int x = Random().nextInt(3);
        int y = Random().nextInt(3);

        changeMatrixField(x, y, true);
        checkWinner(x, y);
      }
    }
  }

  @override
  void onInit() async {
    //modelHasLoaded.value = await getModel();

    _initMatrix();
    super.onInit();
  }

  Future<bool> postJogoDaVelha(bool hasWon) async {
    loading.value = true;
    try {
      var response = await repository.postJogoDaVelha(hasWon);
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
      }
      loading.value = false;
      if (hasWon) {
        SnackBarUtils.showSnackBar(
            desc: 'Você ganhou 5 troféus, por vencer no Jogo da Velha!',
            title: 'Parabéns',
            color: primaryColor);
      }
      DartNotificationCenter.post(channel: 'refreshCla');
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente.", title: "Atenção");
      loading.value = false;
      return false;
    }
  }

  Future<bool> getModel() async {
    try {
      var response = await repository.getModel();

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return false;
      }

      this.model = response;
      bagIsEquiped.value = this.model.hunterTrophy.bag;
      btnDuplicateIsEnabled.value = !this.model.hunterTrophy.hunting;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      return false;
    }
  }

  postBag() async {
    postBagHasLoaded.value = false;

    TrophyHuntModelRequest request = TrophyHuntModelRequest();
    request.bag = bagIsEquiped.value;

    try {
      var response = await repository.postBag(request);

      if (ExceptionUtils.verifyIfIsException(response)) {
        postBagHasLoaded.value = true;
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return;
      }

      SnackBarUtils.showSnackBar(
          desc:
              'Você esta na caçada, no final da rodada será notificado em seu retorno!',
          title: 'Parabéns!',
          color: primaryColor);
      await getModel();
      postBagHasLoaded.value = true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, atualize a página.",
          title: "Atenção");
      postBagHasLoaded.value = true;
    }
  }

  void equipBag() {
    if (bagIsEquiped.value) {
      return;
    }
    btnDuplicateIsEnabled.value = false;
    bagIsEquiped.value = true;
  }

  int getTimestamp() {
    DateTime now = DateTime.now();

    DateTime nextDay = DateTime(now.year, now.month, now.day, now.hour, 59, 59);
    return nextDay.millisecondsSinceEpoch;
  }
}
