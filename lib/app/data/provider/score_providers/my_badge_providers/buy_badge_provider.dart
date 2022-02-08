import 'package:cGamer/app/data/models/score_models/buy_badges/my_badges_model.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/my_badge_endpoints/buy_badge_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';

import '../../../../utils/api_utils/api_exports.dart';

class MyBadgeProvider {
  MyBadgeProvider({required this.requester});
  final Requester requester;

  Future getBadges() async {
    try {
      var response = await requester.fetch(
          url: MyBadgeEndpoints.badges(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future chooseBadge(MyBadgeModelRequest request) async {
    try {
      var response = await requester.post(
          url: MyBadgeEndpoints.badges(),
          body: request.toJson(),
          header: await Headers().getAuthenticatedHeader());
      return response;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
