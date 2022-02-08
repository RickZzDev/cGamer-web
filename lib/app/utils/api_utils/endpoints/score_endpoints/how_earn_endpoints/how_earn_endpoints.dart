import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class HowEarnEndpoints {
  static String _url = '/gamification';
  static String howEarn() => _url + '/howearn';
}
