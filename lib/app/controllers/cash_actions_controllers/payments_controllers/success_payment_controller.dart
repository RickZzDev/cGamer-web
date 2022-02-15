import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:get/get.dart';

class BillPaymentSuccessController extends GetxController {
  BillPaymentConfirmResponseModel model = BillPaymentConfirmResponseModel();

  @override
  void onInit() {
    model = Get.arguments['bill_payment_model'];
    super.onInit();
  }
}
