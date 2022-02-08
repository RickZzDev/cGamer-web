import 'package:cGamer/app/data/models/score_models/buy_badges/buy_badge_model.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/buy_badge_endpoints/buy_badge_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';

import '../../../../utils/api_utils/api_exports.dart';

class BuyBadgeProvider {
  BuyBadgeProvider({required this.requester});
  final Requester requester;

  Future getBadges() async {
    try {
      var response = await requester.fetch(
          url: BuyBadgeEndpoints.badges(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future buyBadge(BuyBadgeModelRequest request) async {
    try {
      var response = await requester.post(
          url: BuyBadgeEndpoints.badges(),
          body: request.toJson(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
