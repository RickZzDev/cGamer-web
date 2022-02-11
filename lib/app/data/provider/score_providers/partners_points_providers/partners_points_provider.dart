import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/partners_points_endpoints/partners_points_endpoint.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:meta/meta.dart';

class PartnerPointsApiClient {
  final Requester httpClient;

  PartnerPointsApiClient({required this.httpClient});

  Future getPartners() async {
    var response = await Requester().fetch(
        url: PartnerPointsEndpoints.partners(),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
