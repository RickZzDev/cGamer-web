import 'package:cGamer/app/controllers/score/payment/payment_score_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/payment_score_providers/payment_score_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/payment_score_repository/payment_score_repository.dart';
import 'package:get/get.dart';

class PaymentScoreBinding implements Bindings {
  @override
  void dependencies() {
    PaymentScoreProvider provider = PaymentScoreProvider();
    PaymentScoreRepository repository = PaymentScoreRepository(provider);

    Get.lazyPut<PaymentScoreController>(
        () => PaymentScoreController(repository));
  }
}
