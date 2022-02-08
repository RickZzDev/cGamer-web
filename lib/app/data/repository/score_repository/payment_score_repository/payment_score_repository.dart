import 'package:cGamer/app/data/provider/score_providers/payment_score_providers/payment_score_provider.dart';

class PaymentScoreRepository {
  final PaymentScoreProvider provider;

  PaymentScoreRepository(this.provider);

  Future<dynamic> postCashbackPurchase(String password, int productId) async {
    try {
      var response = await provider.postCashbackProduct(password, productId);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postGiftCardProduct(String password, int productId) async {
    try {
      var response = await provider.postGiftCardProduct(password, productId);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
