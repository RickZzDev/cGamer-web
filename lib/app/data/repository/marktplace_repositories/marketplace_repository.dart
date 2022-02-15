import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/marketplace_provider.dart';
import 'package:meta/meta.dart';

class MarketPlaceRepository {
  final MarketPlaceProvider apiClient;

  MarketPlaceRepository({required this.apiClient});

  digitalProductCollections() async {
    return await apiClient.digitalProductCollections(null);
  }

  storePartnerCollections() async {
    return await apiClient.storePartnerCollections(null);
  }

  products(int collectionId) async {
    return await apiClient.products(collectionId);
  }

  purchase(DigitalProduct product, String password) async {
    return await apiClient.purchase(product, password);
  }

  digitalProductCollectionsByCategory(String category) async {
    return await apiClient.digitalProductCollections(category);
  }

  storePartnerCollectionsByCategory(String category) async {
    return await apiClient.storePartnerCollections(category);
  }

  offers() async {
    return await apiClient.offers();
  }
}
