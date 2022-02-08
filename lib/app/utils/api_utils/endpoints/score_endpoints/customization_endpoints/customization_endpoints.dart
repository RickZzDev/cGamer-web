import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class CustomizationEndpoints {
  static String url = "/gamification";

  static String colors() => url + "/colors";
}
