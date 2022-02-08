import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/success_payment_controller.dart';
import 'package:get/get.dart';

class BillPaymentSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillPaymentSuccessController>(
        () => BillPaymentSuccessController());
  }
}
