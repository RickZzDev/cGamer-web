import 'package:cGamer/app/controllers/clan_controllers/clan_ranking_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_ranking_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_ranking_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ClanRankingBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ClanRankingProvider provider = ClanRankingProvider(requester: requester);
    ClanRankingRepository repository =
        ClanRankingRepository(provider: provider);
    Get.lazyPut<ClanRankingController>(
        () => ClanRankingController(repository: repository));
  }
}
