import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class RegisterApiClient {
  final http.Client httpClient;
  RegisterApiClient({required this.httpClient});

  add(UserRegisterModel _user) async {
    var url = AuthEndpoints().registerEndpoint;

    var response = await Requester().post(url: url, body: _user);

    return response;
  }
}
