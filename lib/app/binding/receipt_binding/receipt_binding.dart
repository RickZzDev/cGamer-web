import 'package:cGamer/app/controllers/cash_actions_controllers/receipt_controller/receipt_controller.dart';
import 'package:get/get.dart';

class ReceiptBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptController>(() => ReceiptController());
  }
}
