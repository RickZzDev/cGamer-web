import 'package:cGamer/app/controllers/clan_controllers/clan_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ClanBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ClanProvider provider = ClanProvider(requester: requester);
    ClanRepository repository = ClanRepository(provider: provider);

    Get.lazyPut<ClanController>(() => ClanController(repository: repository));
  }
}
