import 'package:cGamer/app/controllers/profile/account_data/account_data_list_controller.dart';
import 'package:get/get.dart';

class AccountDataListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountDataListController>(() => AccountDataListController());
  }
}
