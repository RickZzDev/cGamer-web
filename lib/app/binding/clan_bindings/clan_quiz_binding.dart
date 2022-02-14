import 'package:cGamer/app/controllers/clan_controllers/clan_jogo_velha_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_quiz_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_trophy_hunt_controller.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_machine_trophy_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_quiz_provider.dart';
import 'package:cGamer/app/data/provider/clan_providers/clan_details_providers/clan_trophy_hunt_provider.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_machine_trophy_repository.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_quiz_repository.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_trophy_hunt_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class QuizBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    QuizProvider provider = QuizProvider(requester);
    QuizRepository repository = QuizRepository(provider);

    Get.lazyPut<QuizController>(() => QuizController(repository));
  }
}
