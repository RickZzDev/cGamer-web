import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/models/market_place_model/marketplace_model.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MarketPlaceSuccessController extends GetxController {
  DigitalProduct? product;
  DigitalProductDetail? productDetail;
  MarketplacePurchaseResponse? response;
  var isPrime = false.obs;

  @override
  void onInit() async {
    product = Get.arguments['product'];
    productDetail = Get.arguments['productDetail'];
    response = Get.arguments['response'];
    isPrime.value = await PrimeUtils.isPrime();

    super.onInit();
  }

  void copyPin() {
    Clipboard.setData(ClipboardData(text: response?.pin));
  }
}
