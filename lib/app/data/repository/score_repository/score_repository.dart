import 'dart:convert';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/data/provider/score_providers/score_provider.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class ScoreRepository {
  final ScoreApiClient apiClient;

  ScoreRepository({required this.apiClient});

  getScore() async {
    return await apiClient.getScore();
  }

  getMissions() async {
    return await apiClient.getMissions();
  }

  getRanking() async {
    return await apiClient.getRanking();
  }

  getActions() async {
    return await apiClient.getActions();
  }

  getDaily() async {
    return await apiClient.getDaily();
  }

  checkInDaily(int id) async {
    return await apiClient.checkInDaily(id);
  }

  getTransactions() async {
    return await apiClient.getTransactions();
  }

  Future<HowEarnModel> getHowEarnList() async {
    var response = await apiClient.getHowEarn();
    return HowEarnModel.fromJson(
      json.decode(utf8.decode(response.bodyBytes)),
    );
  }

  getGiftCards() async {
    try {
      Response response = await apiClient.getGiftCards();
      GiftCardModel result =
          GiftCardModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
