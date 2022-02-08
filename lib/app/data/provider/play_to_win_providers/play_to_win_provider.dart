import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';

class PlayToWinProvider {
  final Requester requester;
  PlayToWinProvider(this.requester);

  Future<dynamic> getPlayToWinGames() async {
    var response = await Requester().fetch(
        url: PlayToWinEndpoints.gamesListUrl,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getAccountDetail(int id) async {
    var response = await requester.fetch(
        url: PlayToWinEndpoints.accountDetails(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> syncAccount(int id) async {
    var response = await requester.fetch(
        url: PlayToWinEndpoints.syncAccount(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> rescuePoints(int id) async {
    var response = await requester.post(
        url: PlayToWinEndpoints.rescuePoints(id),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
