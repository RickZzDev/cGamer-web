import 'package:cGamer/app/data/models/market_place_model/store_collections_model.dart';
import 'package:get/get.dart';

class StorePartnerDetailController extends GetxController {
  StorelCollectionModel? storeCollection;

  @override
  void onInit() {
    storeCollection = Get.arguments['store_collection'];
    super.onInit();
  }
}
