import 'package:cGamer/app/controllers/marketplace/category_games_controller.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/category_games_provider.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/category_games_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryGamesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryGamesController>(
      () => CategoryGamesController(
        repository: CategoryGamesRepository(
          apiClient: CategoryGamesProvider(
            httpClient: http.Client(),
          ),
        ),
      ),
    );
  }
}
