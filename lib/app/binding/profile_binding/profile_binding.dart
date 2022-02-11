import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/data/provider/profile_provider/profile_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/profile_repository.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Requester client = Requester();
    ProfileApiClient _apiClient = ProfileApiClient(httpClient: client);
    Get.lazyPut<ProfileController>(
      () => ProfileController(
          repository: ProfileRepository(apiClient: _apiClient)),
    );
  }
}
