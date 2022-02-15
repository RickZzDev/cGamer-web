import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cGamer/app/controllers/profile/faq/faq_category_controller.dart';
import 'package:cGamer/app/data/provider/profile_provider/faq_provider/faq_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/faq_repository/faq_repository.dart';

class FAQCategoryBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    FAQApiClient _apiClient = FAQApiClient(httpClient: client);
    Get.lazyPut<FAQCategoryController>(
      () => FAQCategoryController(
        repository: FAQRepository(apiClient: _apiClient),
      ),
    );
  }
}
