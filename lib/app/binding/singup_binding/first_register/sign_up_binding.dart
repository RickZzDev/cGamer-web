import 'package:cGamer/app/controllers/signup/fisrt_register/signup_email_controller.dart';
import 'package:get/get.dart';

class SignUpEmailStepBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpEmailStepController>(() => SignUpEmailStepController());
  }
}
