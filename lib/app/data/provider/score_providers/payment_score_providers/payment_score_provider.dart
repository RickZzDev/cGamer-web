import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/exclusivity_endpoints/cashback_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/score_endpoints/gift_cards_endpoints/gift_cards_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';

class PaymentScoreProvider {
  Future<dynamic> postCashbackProduct(String password, int productId) async {
    CashbackPurchaseModel body =
        CashbackPurchaseModel(password: password, productId: productId);

    var response = await new Requester().post(
        url: CashbackEndpoints.postCashbackUrl,
        header: await Headers().getAuthenticatedHeader(),
        body: body.toJson());
    return response;
  }

  Future<dynamic> postGiftCardProduct(String password, int productId) async {
    final GiftCardPurchaseModel body =
        GiftCardPurchaseModel(password: password, productId: productId);

    var response = await new Requester().post(
        url: GiftCardEndpoints.postGiftCardUrl,
        body: body.toJson(),
        header: await Headers().getAuthenticatedHeader());

    return response;
  }
}
