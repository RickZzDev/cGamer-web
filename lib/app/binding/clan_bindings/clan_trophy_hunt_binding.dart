import 'package:cGamer/app/controllers/clan_controllers/clan_trophy_hunt_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_trophy_hunt_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_trophy_hunt_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ClanTrophyHuntBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ClanTrophyHuntProvider provider = ClanTrophyHuntProvider(requester);
    ClanTrophyHuntRepository repository = ClanTrophyHuntRepository(provider);

    Get.lazyPut<ClanTrophyHuntController>(() => ClanTrophyHuntController(repository));
  }
}
