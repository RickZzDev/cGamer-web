import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:meta/meta.dart';

class MyProgressApiClient {
  final Requester httpClient;

  MyProgressApiClient({required this.httpClient});

  getLevels() async {
    var response = await Requester().fetch(
        url: MyProgressEndpoint.levels,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getMyProgressInfo() async {
    var response = await Requester().fetch(
        url: MyProgressEndpoint.info,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
