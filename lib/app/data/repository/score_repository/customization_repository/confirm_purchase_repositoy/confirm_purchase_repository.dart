import 'package:cGamer/app/data/provider/score_providers/customization_providers/confirm_purchase_provider/confirm_purchase_provider.dart';
import 'package:meta/meta.dart';

class ConfirmPurchaseRepository {
  ConfirmPurchaseRepository({required this.provider});

  final ConfirmPurchaseProvider provider;

  Future confirmPurchase(
      {required String color, required String password}) async {
    var response =
        await provider.confirmPurchase(color: color, password: password);
    return response;
  }
}
