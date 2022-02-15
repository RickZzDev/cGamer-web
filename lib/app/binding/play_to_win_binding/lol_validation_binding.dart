import 'package:cGamer/app/controllers/play_to_win/games/lol/lol_account_validation/lol_account_validation_controller.dart';
import 'package:cGamer/app/data/provider/play_to_win_providers/lol_providers/lol_provider.dart';
import 'package:cGamer/app/data/repository/play_to_win_repositories/lol_repositories/lol_connection_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class LolVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    LolProvider provider = LolProvider(requester);
    LolRepository repository = LolRepository(provider: provider);
    Get.lazyPut<LolAccountValidationController>(
        () => LolAccountValidationController(repository: repository));
  }
}
