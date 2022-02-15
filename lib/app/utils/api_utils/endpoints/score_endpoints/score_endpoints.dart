import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class ScoreEndpoints {
  static String url = "/gamification";

  static String score() => url + '/customer';

  static String ranking() => url + '/ranking';

  static String actions() => url + '/action';

  static String daily() => url + '/daily';
  static String checkInDaily(int id) => url + '/daily/$id';
  static String transactions() => url + '/transactions';
}
