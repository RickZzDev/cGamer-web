import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/my_badge_endpoints/buy_badge_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:meta/meta.dart';

class ProfileApiClient {
  final Requester httpClient;

  ProfileApiClient({required this.httpClient});

  getStatusRegister() async {
    var response = await Requester().fetch(
        url: RegisterStatusEdnpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getProfile() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future getBedges() async {
    var response = await Requester().fetch(
        url: MyBadgeEndpoints.badges(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
