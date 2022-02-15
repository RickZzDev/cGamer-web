import 'package:cGamer/app/controllers/score/customization/confirm_purchase/confirm_purchase_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/customization_providers/confirm_purchase_provider/confirm_purchase_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/customization_repository/confirm_purchase_repositoy/confirm_purchase_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ConfirmPurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    Get.lazyPut<ConfirmPurchaseController>(() => ConfirmPurchaseController(
        repository: ConfirmPurchaseRepository(
            provider: ConfirmPurchaseProvider(requester: requester))));
  }
}
