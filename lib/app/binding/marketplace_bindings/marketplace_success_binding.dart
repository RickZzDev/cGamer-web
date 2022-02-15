import 'package:cGamer/app/controllers/marketplace/marketplace_success_controller.dart';
import 'package:get/get.dart';

class MarketPlaceSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketPlaceSuccessController>(
        () => MarketPlaceSuccessController());
  }
}
