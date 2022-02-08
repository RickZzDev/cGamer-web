import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class FAQApiClient {
  final http.Client httpClient;
  FAQApiClient({required this.httpClient});

  getCategories() async {
    var response = await Requester().fetch(
        url: FAQEndpoint.categories,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getQuestions(int categoryId) async {
    var response = await Requester().fetch(
        url: FAQEndpoint.questions + "/$categoryId",
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
