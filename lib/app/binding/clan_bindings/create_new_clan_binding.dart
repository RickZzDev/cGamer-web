import 'package:cGamer/app/controllers/clan_controllers/create_new_clan_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/create_new_clan_providers/create_new_clan_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/create_new_clan_repositories/create_new_clan_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class CreateNewClanBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    CreateNewClanProvider provider =
        CreateNewClanProvider(requester: requester);
    CreateNewClanRepository repository =
        CreateNewClanRepository(provider: provider);

    Get.lazyPut<CreateNewClanController>(
        () => CreateNewClanController(repository: repository));
  }
}
