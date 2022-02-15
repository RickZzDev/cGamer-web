import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_account_info_controller.dart';
import 'package:get/get.dart';

class TedAccountInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TedAccountInfoController>(() => TedAccountInfoController());
  }
}
