import 'package:cGamer/app/data/provider/marketplace_providers/marketplace_provider.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';

class MarketplaceBinding implements Bindings {
  @override
  void dependencies() {
    final Requester requester = Requester();
    MarketPlaceProvider _apiClient = MarketPlaceProvider(requester: requester);

    Get.lazyPut<MarketplaceController>(() => MarketplaceController(
        repository: MarketPlaceRepository(apiClient: _apiClient)));
  }
}
