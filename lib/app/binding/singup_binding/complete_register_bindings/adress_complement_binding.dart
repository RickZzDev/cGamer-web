import 'package:cGamer/app/controllers/signup/complete_register/adress_complement_controller.dart';
import 'package:get/get.dart';

class AdressComplementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdressComplementController>(() => AdressComplementController());
  }
}
