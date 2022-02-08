import 'package:cGamer/app/data/provider/profile_provider/profile_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/profile_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/invite_friend/invite_friend_controller.dart';

class InviteFriendBinding implements Bindings {
  @override
  void dependencies() {
    Requester apiClient = Requester();
    Get.lazyPut<InviteFriendController>(
      () => InviteFriendController(
        repository: ProfileRepository(
          apiClient: ProfileApiClient(httpClient: apiClient),
        ),
      ),
    );
  }
}
