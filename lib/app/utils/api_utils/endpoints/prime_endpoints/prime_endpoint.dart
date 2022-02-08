import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class PrimeEndpoints {
  static String confirmIOSPurchase(
    String purchaseId,
  ) =>
      '/assign/inapppurchase/ios' + '/$purchaseId' + '/confirm';

  static String confirmAndroidPurchase(
    String purchaseId,
  ) =>
      '/assign/inapppurchase/android' + '/$purchaseId' + '/confirm';

  static String getBenefits = '/assign/benefits';
  static String getInfo = '/assign/info';

  static String rescueReward(int idReward) => '/assign/reward/$idReward';
  static String saveDiscordId(String id) => '/customer/discord/$id';
}
