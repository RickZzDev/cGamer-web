import 'package:cGamer/app/controllers/marketplace/subcategory_controller.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/subcategory_provider.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/subcategory_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class SubCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(
      () => SubCategoryController(
        repository: SubCategoryRepository(
          apiClient: SubCategoryProvider(
            requester: Requester(),
          ),
        ),
      ),
    );
  }
}
