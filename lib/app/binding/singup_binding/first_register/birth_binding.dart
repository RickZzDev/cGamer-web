import 'package:cGamer/app/controllers/signup/fisrt_register/birth_controller.dart';
import 'package:get/get.dart';

class BirthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BirthController>(() => BirthController());
  }
}
