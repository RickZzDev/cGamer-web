import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class PhoneCodeApiClient {
  final http.Client httpClient;
  PhoneCodeApiClient({required this.httpClient});

  sendSmsCode(String _phone) async {
    Map<String, String> _params = {'phone': _phone};

    var response = await Requester().post(
        url: CompleteRegisterEndpoints().sendSms(),
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }

  sendCompleteRegister(Map<String, dynamic> _body) async {
    var response = await Requester().post(
        url: CompleteRegisterEndpoints().sendRegisterComplete(),
        header: await Headers().getAuthenticatedHeader(),
        body: _body);
    return response;
  }
}
