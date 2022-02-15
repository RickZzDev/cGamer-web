import 'package:cGamer/app/utils/api_utils/endpoints/sign_up_endpoints/retrive_password_endpoints/retrive_password_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RetrivePasswordCodeApiClient {
  final http.Client httpClient;
  RetrivePasswordCodeApiClient({required this.httpClient});

  validateCode(String email, String code) async {
    var url =
        RetrivePasswordEndpoints().recoveryPassword + "/$email/validate/$code";
    var response = await Requester().post(url: url);
    return response;
  }
}
