import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class PlayToWinEndpoints {
  static final String _url = '/playwin';
  static final String gamesListUrl = _url + '/games';

  static String accountDetails(
    int id,
  ) =>
      gamesListUrl + '/$id' + '/details';

  static String syncAccount(
    int id,
  ) =>
      gamesListUrl + '/$id' + '/sync';

  static String rescuePoints(
    int id,
  ) =>
      gamesListUrl + '/$id' + '/rescue';

  static String connectAccount(int gameId, String gameNick) =>
      gamesListUrl + '/$gameId' + '/connect' + '/$gameNick';
}
