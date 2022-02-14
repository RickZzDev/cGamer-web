import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class PhoneStepApiClient {
  final http.Client httpClient;
  PhoneStepApiClient({required this.httpClient});

  sendSmsCode(String _phone) async {
    Map<String, String> _params = {'phone': _phone};

    var response = await Requester().post(
        url: CompleteRegisterEndpoints().sendSms(),
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }
}
