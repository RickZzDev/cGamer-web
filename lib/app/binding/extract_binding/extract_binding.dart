import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/data/provider/extract_provider/extract_provider.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/extract_repositories/extract_repository.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class ExtractBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    ExtractProvider extractProvider = ExtractProvider(httpClient: requester);
    ExtractRepository extractRepository =
        ExtractRepository(provider: extractProvider);

    Requester httpClient = Requester();
    HomeApiClient client = HomeApiClient(httpClient: httpClient);
    Get.lazyPut<ExtractController>(
      () => ExtractController(
          extractRepository: extractRepository,
          repository: HomeRepository(apiClient: client)),
    );
  }
}
