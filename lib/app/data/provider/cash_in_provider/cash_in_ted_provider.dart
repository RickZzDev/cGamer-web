import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class CashInTedApiClient {
  final http.Client httpClient;
  CashInTedApiClient({required this.httpClient});

  getBankAccount() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
