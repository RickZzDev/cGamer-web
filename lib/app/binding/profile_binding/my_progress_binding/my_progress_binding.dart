import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/profile/my_progress/my_progress_controller.dart';
import 'package:cGamer/app/data/provider/profile_provider/my_progress_provider/my_progress_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/my_progress_repository/my_progress_repository.dart';

class MyProgressBinding implements Bindings {
  @override
  void dependencies() {
    Requester client = Requester();
    MyProgressApiClient _apiClient = MyProgressApiClient(httpClient: client);
    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);
    Get.lazyPut<MyProgressController>(
      () => MyProgressController(
          repository: MyProgressRepository(apiClient: _apiClient),
          homeRepository: HomeRepository(apiClient: _homeApiClient)),
    );
  }
}
