import 'package:get/get.dart';

class VirtualCardBlockSuccessController extends GetxController {
  String action = "";

  @override
  void onInit() {
    action = Get.arguments != null ? Get.arguments["action"] : "";
    super.onInit();
  }
}
