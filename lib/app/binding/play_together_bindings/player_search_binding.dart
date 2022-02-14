import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/search_player_controller.dart';
import 'package:cGamer/app/data/provider/play_together_providers/play_together_provider.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/play_together_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class PlayerSearchBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    PlayTogetherProvider provider = PlayTogetherProvider(requester);
    PlayTogetherRepository repository = PlayTogetherRepository(provider);
    Get.lazyPut<SearchPlayerController>(
        () => SearchPlayerController(repository: repository));
  }
}
