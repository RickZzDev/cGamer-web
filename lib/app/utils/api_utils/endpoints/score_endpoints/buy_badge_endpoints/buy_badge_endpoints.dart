import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class BuyBadgeEndpoints {
  static String url = "/gamification";
  static String badges() => url + "/badges";
}
