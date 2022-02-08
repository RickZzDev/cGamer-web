import 'package:cGamer/app/controllers/main_page_holder/page_holder_controller.dart';
import 'package:get/get.dart';

class PagesHolderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PagesHolderController>(() => PagesHolderController());
  }
}
