import 'package:cGamer/app/controllers/signup/fisrt_register/signup_name_preferences.dart';
import 'package:get/get.dart';

class NamePreferrencesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NamePreferrencesController>(() => NamePreferrencesController());
  }
}
