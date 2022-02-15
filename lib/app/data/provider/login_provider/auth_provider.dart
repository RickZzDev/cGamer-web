import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:cGamer/app/data/models/auth_model/auth_model.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';

class AuthApiClient {
  final http.Client httpClient;
  AuthApiClient({required this.httpClient});

  auth(String cpf, String password) async {
    try {
      var url = AuthEndpoints().authEndpoint;

      var body = AuthRequestModel(cpf: cpf, password: password).toJson();
      var response = await Requester().postV2(url: url, body: body);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
