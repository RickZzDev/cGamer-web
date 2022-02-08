import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/how_earn_endpoints/how_earn_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/gift_cards_endpoints/gift_cards_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/score_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:meta/meta.dart';

class ScoreApiClient {
  final Requester httpClient;

  ScoreApiClient({required this.httpClient});

  Future getHowEarn() async {
    var response = await Requester().fetch(
        url: HowEarnEndpoints.howEarn(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getScore() async {
    var response = await Requester().fetch(
        url: ScoreEndpoints.score(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getMissions() async {
    var response = await httpClient.fetch(
        url: HomeEndpoint.urlMissions,
        header: await Headers().getAuthenticatedHeader());

    return response;
  }

  getRanking() async {
    var response = await Requester().fetch(
        url: ScoreEndpoints.ranking(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getActions() async {
    var response = await Requester().fetch(
        url: ScoreEndpoints.actions(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getDaily() async {
    var response = await Requester().fetch(
        url: ScoreEndpoints.daily(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  checkInDaily(int id) async {
    var response = await Requester().post(
        url: ScoreEndpoints.checkInDaily(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getTransactions() async {
    var response = await Requester().fetch(
        url: ScoreEndpoints.transactions(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getGiftCards() async {
    var response = await Requester().fetch(
        url: GiftCardEndpoints.giftcardsUrl,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
