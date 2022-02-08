import 'package:get/get.dart';
import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_confirm_controller.dart';

class PhoneRechargeConfirmBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneRechargeConfirmController>(
        () => PhoneRechargeConfirmController());
  }
}
