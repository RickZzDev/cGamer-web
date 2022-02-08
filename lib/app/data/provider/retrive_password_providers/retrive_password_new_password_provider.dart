import 'package:cGamer/app/utils/api_utils/endpoints/sign_up_endpoints/retrive_password_endpoints/retrive_password_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RetrivePasswordNewPasswordApiClient {
  final http.Client httpClient;
  RetrivePasswordNewPasswordApiClient({required this.httpClient});

  changePassword(String email, String code, String newPassword) async {
    Map<String, String>? _params = {
      "password": newPassword,
      "codeRecovery": code
    };
    var url = RetrivePasswordEndpoints().recoveryPassword + "/$email/reset";

    var response = await Requester().post(url: url, params: _params);

    return response;
  }
}
