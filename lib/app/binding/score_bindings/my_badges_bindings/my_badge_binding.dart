import 'package:cGamer/app/controllers/score/my_badges/my_badge_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/my_badge_providers/buy_badge_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/my_badge_repository/buy_badge_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class MyBadgeBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    Get.lazyPut<MyBadgeController>(() => MyBadgeController(
        repository: MyBadgeRepository(
            provider: MyBadgeProvider(requester: requester))));
  }
}
