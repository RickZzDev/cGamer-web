import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/subcategory_provider.dart';
import 'package:meta/meta.dart';

class SubCategoryRepository {
  final SubCategoryProvider apiClient;

  SubCategoryRepository({required this.apiClient});

  productDetails(DigitalProduct? product) {
    return apiClient.productDetails(product);
  }

  // getId(id) {
  //   return apiClient.getId(id);
  // }

  // delete(id) {
  //   return apiClient.delete(id);
  // }

  // edit(obj) {
  //   return apiClient.edit(obj);
  // }

  // add(obj) {
  //   return apiClient.add(obj);
  // }
}
