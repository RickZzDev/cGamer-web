import 'dart:convert';

import 'package:cGamer/app/data/models/market_place_model/digital_collections_model.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/subcategory_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/marketplace/carousel_banner_component.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class SubCategoryController extends GetxController {
  final SubCategoryRepository repository;
  SubCategoryController({required this.repository});

  List<DigitalProduct>? products;
  List<DigitalCollection>? collections;
  Rx<DigitalProductDetail?> productDetailModel =
      Rx<DigitalProductDetail?>(null);
  final title = "".obs;
  final loading = false.obs;
  var isPrime = false.obs;

  @override
  void onInit() async {
    products = Get.arguments['products'];
    collections = Get.arguments['collections'];
    title.value = Get.arguments['title'];
    isPrime.value = await PrimeUtils.isPrime();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<dynamic> getProductDetails(DigitalProduct? product) async {
    loading.value = true;
    try {
      var response = await repository.productDetails(product);
      productDetailModel.value = DigitalProductDetail.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );

      Get.toNamed(Routes.MARKETPLACE_CONFIRM_BUY, arguments: {
        'productDetail': productDetailModel.value,
        'product': product
      });
      loading.value = false;
    } catch (e) {
      loading.value = false;
      return Future.error(e);
    }
  }

  final List<CarouselBanner> bannersCarousel = [
    CarouselBanner(
        urlImage:
            "https://images.tcdn.com.br/img/editor/up/477758/BANNER_FORTREK.png",
        action: () {}),
    CarouselBanner(
        urlImage:
            "https://images.tcdn.com.br/img/img_prod/767588/1591385990_banner_game.jpg",
        action: () {}),
    CarouselBanner(
        urlImage:
            "https://overbr.com.br/wp-content/uploads/2015/07/banner-4.jpg",
        action: () {})
  ];
}
