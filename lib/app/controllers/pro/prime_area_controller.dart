import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/data/models/prime_models/prime_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/discord_utils/discord_manager.dart';
import 'package:cGamer/app/utils/api_utils/discord_utils/models/discord_user.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:get/get.dart';

class PrimeAreaController extends GetxController {
  final ProRepository repository;
  PrimeAreaController({required this.repository});

  var loading = false.obs;

  RxList<PrimeBenefits> benefits = RxList();
  Rx<PrimeInfoModel> infoModel = PrimeInfoModel().obs;
  HomeModel userStats = HomeModel();
  var indexBenefitSelected = 99.obs;

  Rx<DiscordManager> discordManager = DiscordManager(
      clientId: "916523930867601489",
      clientSecret: "QabNVmRSp8G7g2CQgRymm_UgaFGESXb8",
      redirectUrl: "jogga://discord",
      scopes: [
        DiscordScope.Identify,
        DiscordScope.Guilds_Join,
      ]).obs;

  Rx<DiscordUser?> discordUser = DiscordUser().obs;
  RxList<FAQQuestion> questions = <FAQQuestion>[].obs;

  @override
  void onInit() async {
    userStats = Get.arguments['userStats'];
    buildBenefits();
    await getInfo();
    buildQuestions();
    super.onInit();
  }

  void buildQuestions() {
    FAQQuestion question = FAQQuestion();
    question.question = "Porque devo conectar minha conta do Discord?";
    question.answer =
        "Ao conectar sua conta do Discord com o Jogga, você permite usufruir de todos os benefícios da assinatura que oferecemos em nosso servidor do Discord, recebendo o cargo de Prime, e ganhando benefícios exclusivos da comunidade.";
    questions.add(question);

    FAQQuestion question0 = FAQQuestion();
    question0.question = "Quando libera mais bônus de Rubis para resgatar?";
    question0.answer =
        "Uma vez ao mês, é liberado o botão para resgatar bônus de Rubis, por ser assinante do Jogga Prime.";
    questions.add(question0);

    FAQQuestion question1 = FAQQuestion();
    question1.question = "O que o item NFT?";
    question1.answer =
        "NFT é a sigla para Non Fungible Tokens, (tokens não fungíveis), que significa, items únicos que podem ser negociados dentro do mercado de cripto-tokens. Esses itens possuem valor real, e podem ser negociados através de criptomoedas. No futuro pretendemos oferecer itens NFT`s em nosso ecossistema, e você adquirindo nosso Prime até o lançamento, irá adquirir um NFT exclusivo dos assinantes.";
    questions.add(question1);

    FAQQuestion question2 = FAQQuestion();
    question2.question =
        "Fiz minha assinatura em uma plataforma, ela vale também para as outras?";
    question2.answer =
        "Ao assinar o Jogga Prime em qualquer plataforma, sua assinatura é válida em todas as outras em que o Jogga estiver disponível.";
    questions.add(question2);

    FAQQuestion question3 = FAQQuestion();
    question3.question = "Porque existe uma assinatura no Jogga?";
    question3.answer =
        "Desenvolver uma plataforma com qualidade não é uma tarefa fácil. Com a sua ajuda, conseguimos manter nossa plataforma e equipe, podendo oferecer a melhor experiência em novas atualizações com muitas novidades sempre!";
    questions.add(question3);

    FAQQuestion question4 = FAQQuestion();
    question4.question = "Como faço para cancelar minha assinatura?";
    question4.answer =
        "Você é livre para cancelar quando quiser, e o caminho é ir em Configurações da sua conta ${Platform.isAndroid ? "no Google Play" : "na Apple Store"}, acessar Assinaturas e solicitar o cancelamento. Sua assinatura será renovada automaticamente, ao menos que efetue o cancelamento 24h antes do término dos respectivos períodos.";
    questions.add(question4);
  }

  void openConnectDiscord() async {
    await discordManager.value.getAuthorizationGrant(Get.context!);
    await discordManager.value.getNewToken();
    discordUser.value = await discordManager.value.getUsersMe() ?? null;
    if (discordUser.value != null) {
      await discordManager.value
          .addMemberToDiscord(discordUser.value?.id ?? "");
      await discordManager.value.setRolePrime(discordUser.value?.id ?? "");
      await saveDiscordId(discordUser.value?.id ?? "");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveDiscordId(String id) async {
    loading.value = true;
    try {
      var response = await repository.saveDiscordId(id);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        await getInfo();
        SnackBarUtils.showSnackBar(
            desc: "Conta do Discord vinculada com sucesso.",
            title: "Parabéns",
            color: primaryColor);
        return;
      }

      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao vincular sua conta do Discord, tente novamente.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao vincular sua conta do Discord, tente novamente.",
          title: "Atenção");
      return;
    }
  }

  Future<void> buildBenefits() async {
    loading.value = true;
    try {
      var response = await repository.getBenefits();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        benefits.value = response.benefits;
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro para buscar os benefícios da assinatura.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro para buscar os benefícios da assinatura.",
          title: "Atenção");
      return;
    }
  }

  Future<void> getInfo() async {
    loading.value = true;
    try {
      var response = await repository.getInfo();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        infoModel.value = response;
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro ao buscar as informações da assinatura.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro ao buscar as informações da assinatura.",
          title: "Atenção");
      return;
    }
  }

  Future<void> rescueReward(int idReward) async {
    loading.value = true;
    try {
      var response = await repository.rescueReward(idReward);
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: "Recompensa resgatada com sucesso.",
            title: "Parabéns",
            color: primaryColor);
        await getInfo();
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro ao buscar as informações da assinatura.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro ao buscar as informações da assinatura.",
          title: "Atenção");
      return;
    }
  }

  void goToAnswer(FAQQuestion model, String categoryTitle) async {
    Get.toNamed(Routes.FAQ_ANSWER,
        arguments: {'question_model': model, 'category_title': categoryTitle});
  }
}
