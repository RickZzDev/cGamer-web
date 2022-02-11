import 'package:cGamer/app/controllers/clan_controllers/clan_iteractions_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_details_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_details_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ClanIterationsBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ClanDetailsProvider provider = ClanDetailsProvider(requester: requester);
    ClanDetailsRepository repository =
        ClanDetailsRepository(provider: provider);
    Get.lazyPut<ClanIteractionsController>(
        () => ClanIteractionsController(repository: repository));
  }
}
