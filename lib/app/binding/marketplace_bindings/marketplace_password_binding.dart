import 'package:cGamer/app/controllers/marketplace/marketplace_password_controller.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/marketplace_provider.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class MarketPlacePasswordBinding implements Bindings {
  @override
  void dependencies() {
    final Requester requester = Requester();
    MarketPlaceProvider _apiClient = MarketPlaceProvider(requester: requester);

    Get.lazyPut<MarketPlacePasswordController>(() =>
        MarketPlacePasswordController(
            repository: MarketPlaceRepository(apiClient: _apiClient)));
  }
}
