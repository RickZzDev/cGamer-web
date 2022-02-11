import 'package:cGamer/app/controllers/score/buy_badge/buy_badge_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/buy_badge_providers/buy_badge_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/buy_badge_repository/buy_badge_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class BuyBadgeBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    Get.lazyPut<BuyBadgeController>(() => BuyBadgeController(
        repository: BuyBadgeRepository(
            provider: BuyBadgeProvider(requester: requester))));
  }
}
