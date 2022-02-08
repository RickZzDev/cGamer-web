import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/customization_providers/customization_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/customization_repository/customization_repository.dart';
import 'package:get/get.dart';

import '../../utils/api_utils/api_exports.dart';

class CustomizationBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    Get.lazyPut<CustomizationController>(() => CustomizationController(
        repository: CustomizationRepository(
            provider: CustomizationProvider(requester: requester))));
  }
}
