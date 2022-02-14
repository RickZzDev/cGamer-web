import 'package:cGamer/app/controllers/marketplace/category_controller.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/marketplace_provider.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(
        repository: MarketPlaceRepository(
          apiClient: MarketPlaceProvider(
            requester: Requester(),
          ),
        ),
      ),
    );
  }
}
