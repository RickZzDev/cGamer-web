import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/sign_up_endpoints/complete_register/username_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UsernameApiClient {
  final http.Client httpClient;
  UsernameApiClient({required this.httpClient});

  verify(String username) async {
    Map<String, String> _params = {'username': username};
    var url = UsernameEndpoints().verify();
    var response = await Requester()
        .fetch(url: url, header: Headers().getBasicHeader(), params: _params);
    return response;
  }
}
