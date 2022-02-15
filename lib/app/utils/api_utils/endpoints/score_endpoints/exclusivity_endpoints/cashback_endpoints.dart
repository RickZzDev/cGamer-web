import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class CashbackEndpoints {
  static String url = '/gamification';
  static String cashbackUrl = url + '/cashback';
  static String postCashbackUrl = cashbackUrl + '/purchase';
}
