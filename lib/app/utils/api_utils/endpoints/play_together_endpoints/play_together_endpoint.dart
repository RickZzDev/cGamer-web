import 'package:cGamer/app/utils/api_utils/api_exports.dart';

final String _url = '/playtogether';

abstract class PlayTogetherEndpoints {
  static final String info = _url + '/info';
  static final String befound = _url + '/be-found';
  static String gamesByPlatform(int platformId) => _url + '/games/$platformId';
  static final String putLocation = _url + '/location';
  static final String nearBy = _url + '/nearby';
  static final String fastMatch = _url + '/fast-match';
  static final String sendInvite = _url + '/invite-player';
}

abstract class AddNewGameEndpoints {
  static String getAllGames(String id) => _url + '/games/$id';
  static String postNewGame = _url + '/games';
}

abstract class EditAGameEndpoints {
  static String editGame({required String platformId, required gameId}) =>
      _url + '/games' + '/$platformId' + '/$gameId';
}
