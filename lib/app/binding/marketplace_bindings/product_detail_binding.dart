import 'package:cGamer/app/controllers/marketplace/product_confirm_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    // final Requester requester = Requester();
    //MarketPlaceProvider _apiClient = MarketPlaceProvider(requester: requester);
    Requester client = Requester();
    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);
    Get.lazyPut<ProductConfirmController>(() => ProductConfirmController(
        repository: HomeRepository(apiClient: _homeApiClient)));
  }
}
