import 'dart:convert';

import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';

class LolProvider {
  final Requester requester;
  LolProvider(this.requester);

  Future<dynamic> connectAccount(int gameId, String gameNick) async {
    var response = await requester.post(
        header: await Headers().getAuthenticatedHeader(),
        url: PlayToWinEndpoints.connectAccount(gameId, gameNick));
    return response;
  }
}
