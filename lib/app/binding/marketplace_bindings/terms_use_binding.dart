import 'package:cGamer/app/controllers/marketplace/terms_use_controller.dart';
import 'package:get/get.dart';

class TermsUseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsUseController>(() => TermsUseController());
  }
}
