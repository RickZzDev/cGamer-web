import '../../controllers/onboard/onboard_controller.dart';
import 'package:get/get.dart';

class OnBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardController>(() => OnBoardController());
  }
}
