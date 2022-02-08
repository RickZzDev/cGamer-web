import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_balance_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/mafa_last_moviments_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:get/get.dart';

class CoinWalletController extends GetxController {
  final CoinWalletRepository repository;
  CoinWalletController({required this.repository});

  var currentBalanceFinished = false.obs;
  var mafaExtractFinished = false.obs;

  RxList<FAQQuestion> questions = <FAQQuestion>[].obs;

  Rx<MafaBalanceModel> currentMafaBalance = MafaBalanceModel().obs;
  Rx<LastMafaMovimentsModel> lastMafaMoviments = LastMafaMovimentsModel().obs;

  @override
  void onReady() async {
    DartNotificationCenter.registerChannel(channel: 'refreshMafaWalletPage');
    _subscribeListener();
    buildQuestions();
    _setListenners();
    super.onReady();
  }

  _subscribeListener() {
    DartNotificationCenter.subscribe(
      channel: 'refreshMafaWalletPage',
      observer: this,
      onNotification: (options) async {
        await refresh();
      },
    );
  }

  Future<void> refresh() async {
    await getMafaBalance();
    await getLastMoviments();
  }

  void _showErrorSnackbar() => SnackBarUtils.showSnackBar(
        desc: 'Algo deu errado... tente novamente mais tarde! :(',
        title: "Ops...",
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      );

  _setListenners() {
    currentMafaBalance.listen((p0) {
      currentBalanceFinished.value = true;
      currentBalanceFinished.refresh();
    });

    lastMafaMoviments.listen((p0) {
      mafaExtractFinished.value = true;
      mafaExtractFinished.refresh();
    });
  }

  Future<void> getMafaBalance() async {
    try {
      currentMafaBalance.value = await repository.getMafaBalance();
      if (currentMafaBalance.value.currentCoinValue == -1) {
        SnackBarUtils.showSnackBar(
            desc:
                'Não foi possível buscar a cotação, tente novamente mais tarde!',
            title: "Ops...",
            color: Colors.orange[400]);
      }
      currentMafaBalance.refresh();
    } catch (e) {
      currentBalanceFinished.value = true;
      currentBalanceFinished.refresh();
      _showErrorSnackbar();
    }
  }

  Future<void> getLastMoviments() async {
    try {
      var response = await repository.getLastMoviments();

      lastMafaMoviments.value = response;
      lastMafaMoviments.refresh();
    } catch (e) {
      mafaExtractFinished.value = true;
      mafaExtractFinished.refresh();

      // _showErrorSnackbar();
    }
  }

  void buildQuestions() {
    FAQQuestion question = FAQQuestion();
    question.question = "O que é o \$MAFA Coin?";
    question.answer =
        "Mafacoin é o token do Mafagafo que você pode fazer transações e comprar seus NFT’S. ";
    questions.add(question);

    FAQQuestion question0 = FAQQuestion();
    question0.question = "Conheça o Jogo: Mafagafo";
    question0.answer =
        "O Mafagafo é o primeiro Game NFT brasileiro no mercado. O jogo funciona no modelo “Play to Earn”, literalmente “jogue para ganhar”. Somos um Game NFT de verdade. Não somos só mais uma promessa de lucro, somos de fato um jogo (jogável) que pode ser rentável para todos os jogadores.";
    question0.videoId = "PN8Qi8t0k3g";
    questions.add(question0);

    FAQQuestion question9 = FAQQuestion();
    question9.question = "Como faço para jogar o GAME?";
    question9.answer =
        "A versão Demo do game foi lançado em dezembro/21, onde você tem a chance de jogar o primeiro game NFT do Brasil, em Janeiro/22 aconteceu o lançamento do Play to Earn Inicial, onde pela MafaStore (store.mafagafo.com) você pode comprar seus itens e já começar a lucrar com o jogo. ";
    questions.add(question9);

    FAQQuestion question10 = FAQQuestion();
    question10.question = "Como comprar o Token \$\MAFA?";
    question10.answer =
        "Você pode comprar suas moedas através da PancakeSwap ou aqui pelo Jogga Bank";
    questions.add(question10);

    FAQQuestion question1 = FAQQuestion();
    question1.question = "O que preciso ter para retirar os \$\MAFA?";
    question1.answer =
        "Você precisa ter uma carteira na Blockchain na rede BSC (Binance Smart Chain) e nos informar o ID da carteira no fluxo de Retirar.";
    questions.add(question1);

    FAQQuestion question2 = FAQQuestion();
    question2.question = "Como criar minha carteira na Blockchain?";
    question2.answer =
        "Estamos preparando um tutorial para você fazer o passo a passo e ter sua carteira. Em breve será disponibilizado aqui abaixo!";
    questions.add(question2);

    FAQQuestion question4 = FAQQuestion();
    question4.question = "Consigo estornar uma compra de \$MAFA?";
    question4.answer =
        "Não, após a compra ter sido efetuada, não é possivel realizar o estorno do valor.";
    questions.add(question4);
  }

  void goToAnswer(FAQQuestion model, String categoryTitle) async {
    Get.toNamed(Routes.FAQ_ANSWER,
        arguments: {'question_model': model, 'category_title': categoryTitle});
  }
}
