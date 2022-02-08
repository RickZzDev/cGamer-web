import 'package:cGamer/app/data/models/market_place_model/digital_collections_model.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/category_games_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CategoryGamesController extends GetxController {
  final CategoryGamesRepository repository;
  CategoryGamesController({required this.repository});

  List<DigitalCollection>? collections;
  Rx<DigitalProductDetail?> productDetailModel =
      Rx<DigitalProductDetail?>(null);
  final title = "".obs;
  final loading = false.obs;

  @override
  void onInit() {
    collections = Get.arguments['collections'];
    title.value = Get.arguments['title'];
    super.onInit();
  }
}
