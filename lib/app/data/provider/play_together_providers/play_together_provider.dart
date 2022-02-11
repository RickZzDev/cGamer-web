import 'package:cGamer/app/data/models/play_together_models/invite_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/play_together_endpoints/play_together_endpoint.dart';

class PlayTogetherProvider {
  final Requester requester;
  PlayTogetherProvider(this.requester);

  Future<dynamic> getInfo() async {
    var response = await requester.fetch(
        url: PlayTogetherEndpoints.info,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> changeBeFound(bool beFound) async {
    var response = await requester.post(
        url: PlayTogetherEndpoints.befound,
        body: {'beFound': beFound},
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> putLocation(double latitude, double longitude) async {
    var response = await requester.put(
        url: PlayTogetherEndpoints.putLocation,
        body: {
          'latitude': latitude.toString(),
          'longitude': longitude.toString()
        },
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> getGamesByPlatform(int platformId) async {
    var response = await requester.fetch(
        url: PlayTogetherEndpoints.gamesByPlatform(platformId),
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> removeAGame({
    required String platformId,
    required String gameId,
  }) async {
    var response = await requester.delete(
        header: await Headers().getAuthenticatedHeader(),
        url: EditAGameEndpoints.editGame(
            platformId: platformId, gameId: gameId));
    return response;
  }

  Future<dynamic> editAGame(
      {required String platformId,
      required String gameId,
      required String nickName}) async {
    var body = {"nickName": nickName};

    var response = await requester.put(
        url:
            EditAGameEndpoints.editGame(platformId: platformId, gameId: gameId),
        header: await Headers().getAuthenticatedHeader(),
        body: body);
    return response;
  }

  Future<dynamic> searchFastMatch(int platformId, int gameId) async {
    Map<String, String> _params = {
      "platformId": platformId.toString(),
      "gameId": gameId.toString()
    };
    var response = await requester.fetch(
        url: PlayTogetherEndpoints.fastMatch,
        params: _params,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> searchNearBy(
      int platformId, int gameId, double radius) async {
    Map<String, String> _params = {
      "platformId": platformId.toString(),
      "gameId": gameId.toString(),
      "radius": radius.toString()
    };
    var response = await requester.fetch(
        url: PlayTogetherEndpoints.nearBy,
        params: _params,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  Future<dynamic> sendInvite(PlayTogetherInviteRequest request) async {
    var response = await requester.post(
        header: await Headers().getAuthenticatedHeader(),
        body: request.toJson(),
        url: PlayTogetherEndpoints.sendInvite);
    return response;
  }
}
