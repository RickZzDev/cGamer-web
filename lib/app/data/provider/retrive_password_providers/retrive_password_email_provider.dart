import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/sign_up_endpoints/retrive_password_endpoints/retrive_password_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RetrivePasswordEmailApiClient {
  final http.Client httpClient;
  RetrivePasswordEmailApiClient({required this.httpClient});

  sendCodeForEmail(String email) async {
    var url = RetrivePasswordEndpoints().recoveryPassword + "/$email";

    var response = await Requester().post(url: url);

    return response;
  }
}
