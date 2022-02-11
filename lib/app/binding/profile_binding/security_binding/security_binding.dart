import 'package:cGamer/app/controllers/profile/security/security_controller.dart';
import 'package:get/get.dart';

class SecurityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecurityController>(() => SecurityController());
  }
}
