import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PhoneRechargeConfirmController extends GetxController {
  var hasCompletedProvidersRequest = false.obs;

  var loading = false.obs;
  PhoneRechargeModel model = PhoneRechargeModel();

  @override
  void onInit() {
    model = Get.arguments["phone_recharge_model"];
    model.rechargeDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void changePage() {
    Get.toNamed(Routes.RECHARGE_PHONE_PASSWORD, arguments: {
      'value': model.valueFormatted,
      "type": "phone_recharge",
      "phone_recharge_info": model
    });
  }
}
