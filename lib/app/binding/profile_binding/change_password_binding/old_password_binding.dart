import 'package:cGamer/app/controllers/profile/change_password/old_password_controller.dart';
import 'package:get/get.dart';

class OldPasswordStepBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OldPasswordController>(() => OldPasswordController());
  }
}
