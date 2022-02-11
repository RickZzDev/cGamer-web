import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/avatar_endpoints/avatar_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/clan_endpoints/clan_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/score_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class BankApiClient {
  final Requester httpClient;
  BankApiClient({required this.httpClient});

  getStatusRegister() async {
    var response = await httpClient.fetch(
        url: RegisterStatusEdnpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getHomeStats() async {
    var response = await httpClient.fetch(
        url: HomeEndpoint.url,
        header: await Headers().getAuthenticatedHeader());

    return response;
  }

  getProfile() async {
    var response = await Requester().fetch(
        url: ProfileEndpoint.url,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getBalance() async {
    var response = await httpClient.fetch(
        url: HomeEndpoint.urlBalance,
        header: await Headers().getAuthenticatedHeader());

    return response;
  }

  getHomeExtract(
      {required int size,
      required String initialDate,
      required String finalDate}) async {
    Map<String, String> _params = {
      "pageSize": size.toString(),
      "startDate": initialDate,
      "finalDate": finalDate
    };
    try {
      var response = await httpClient.fetch(
          url: HomeEndpoint.urlExtractHome(size,
              startDate: initialDate, finalDate: finalDate),
          header: await Headers().getAuthenticatedHeader(),
          params: _params);

      return response;
    } catch (e) {
      throw e;
    }
  }

  getAvatars() async {
    var response = await httpClient.fetch(
      url: AvatarEndpoints.getAvatars,
      header: await Headers().getAuthenticatedHeader(),
    );

    return response;
  }

  sendAvatars(Map<String, dynamic> _body) async {
    var response = await httpClient.post(
      url: AvatarEndpoints.getAvatars,
      body: _body,
      header: await Headers().getAuthenticatedHeader(),
    );

    return response;
  }
}
