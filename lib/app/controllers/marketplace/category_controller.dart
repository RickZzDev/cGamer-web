import 'dart:convert';
import 'package:cGamer/app/data/models/market_place_model/digital_collections_model.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/models/market_place_model/store_collections_model.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final MarketPlaceRepository repository;
  CategoryController({required this.repository});

  DigitalCollectionsModel? collectionsModel;
  StoreCollectionsModel? storeCollectionsModel;
  Rx<DigitalProducts> digitalProductsModel = DigitalProducts().obs;

  String title = "";
  final loading = false.obs;

  @override
  void onInit() {
    collectionsModel = Get.arguments['collections'];
    storeCollectionsModel = Get.arguments['store_collections'];
    title = Get.arguments['title'];
    super.onInit();
  }

  Future<dynamic> getProducts(DigitalCollectionModel? model) async {
    loading.value = true;
    try {
      var response = await repository.products(model?.id ?? 0);
      digitalProductsModel.value = DigitalProducts.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      loading.value = false;

      if (digitalProductsModel.value.products != null) {
        Get.toNamed(Routes.MARKETPLACE_SUBCATEGORY_ITEMS, arguments: {
          'products': digitalProductsModel.value.products,
          'title': model?.name
        });
      } else {
        Get.toNamed(Routes.MARKETPLACE_SUBCATEGORY_ITEMS, arguments: {
          'collections': digitalProductsModel.value.collections,
          'title': model?.name
        });
      }
    } catch (e) {
      loading.value = false;
      return Future.error(e);
    }
  }
}
