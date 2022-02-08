import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:get/get.dart';

class PhoneRechargeSuccessController extends GetxController {
  PhoneRechargeModel model = PhoneRechargeModel();

  @override
  void onInit() {
    model = Get.arguments['phone_recharge_model'];
    super.onInit();
  }
}
