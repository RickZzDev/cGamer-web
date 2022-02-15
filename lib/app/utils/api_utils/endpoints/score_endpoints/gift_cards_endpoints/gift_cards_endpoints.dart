import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class GiftCardEndpoints {
  static String url = "/gamification";
  static String giftcardsUrl = url + '/giftcards';
  static String postGiftCardUrl = giftcardsUrl + '/purchase';
}
