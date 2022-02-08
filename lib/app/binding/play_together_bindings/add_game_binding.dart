import 'package:cGamer/app/controllers/play_together_controllers/add_game_controller/add_game_controller.dart';
import 'package:cGamer/app/data/provider/play_together_providers/add_new_game_providers/add_new_game_provider.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/add_new_game_repositories/add_new_game_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class AddGameBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    AddNewGameProvider provider = AddNewGameProvider(requester);
    AddNewGameRepository repository = AddNewGameRepository(provider);
    Get.lazyPut<AddGameController>(
        () => AddGameController(repository: repository));
  }
}
