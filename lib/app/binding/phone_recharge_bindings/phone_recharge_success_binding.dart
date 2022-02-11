import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_success_controller.dart';
import 'package:get/get.dart';

class PhoneRechargeSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneRechargeSuccessController>(
        () => PhoneRechargeSuccessController());
  }
}
