import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PhoneDataApiClient {
  final http.Client httpClient;
  PhoneDataApiClient({required this.httpClient});

  getPhone() async {
    var response = await Requester().fetch(
        url: AccountDataEndpoint.getPhone,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  update(String phone) async {
    Map<String, String>? _params = {'phone': phone};

    var response = await Requester().put(
        url: AccountDataEndpoint.getPhone,
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }
}
