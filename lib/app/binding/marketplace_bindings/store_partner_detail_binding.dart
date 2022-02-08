import 'package:cGamer/app/controllers/marketplace/store_partner_detail_controller.dart';
import 'package:get/get.dart';

class StorePartnerDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorePartnerDetailController>(
        () => StorePartnerDetailController());
  }
}
