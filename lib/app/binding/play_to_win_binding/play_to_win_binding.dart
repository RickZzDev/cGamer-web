import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/data/provider/play_to_win_providers/play_to_win_provider.dart';
import 'package:cGamer/app/data/repository/play_to_win_repositories/play_to_win_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class PlayToWinBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    PlayToWinProvider provider = PlayToWinProvider(requester);
    PlayToWinRepository repository = PlayToWinRepository(provider);

    Get.lazyPut<PlayToWinController>(
        () => PlayToWinController(repository: repository));
  }
}
