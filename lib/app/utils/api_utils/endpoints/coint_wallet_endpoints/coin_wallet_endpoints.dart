abstract class CoinWalletEndpoints {
  static String balance = '/exchange/balance';

  static String transaction = '/exchange/transactions';

  static String exchange(String orderId) =>
      '/exchange/recharge/$orderId/status';
  static String rechargeWithPix = '/exchange/recharge/pix';
}
