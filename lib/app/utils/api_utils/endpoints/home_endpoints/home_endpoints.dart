import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class HomeEndpoint {
  static String url = "/home";
  static String urlMissions = "/missions";
  static String urlBalance = "/balances";
  static String urlExtractHome(int size,
          {String? startDate, String? finalDate}) =>
      "/account/v2/transactions";

  static String getPodcasts = "/customer/podcasts";
}
