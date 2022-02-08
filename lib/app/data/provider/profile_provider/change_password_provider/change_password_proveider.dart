import 'package:cGamer/app/data/models/profile_model/change_password_model/change_password_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/profile_endpoints/change_password_endpoints/change_password_endpoint.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ChangePasswordApiClient {
  final http.Client httpClient;
  ChangePasswordApiClient({required this.httpClient});

  changePassword(String oldPassword, String newPassword) async {
    var body =
        ChangePasswordModel(password: oldPassword, newPassword: newPassword)
            .toJson();
    var response = await Requester().put(
        url: ChangePasswordEndpoint.changePassword,
        body: body,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
