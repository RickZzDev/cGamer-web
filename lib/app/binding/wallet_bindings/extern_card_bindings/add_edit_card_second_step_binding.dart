import 'package:cGamer/app/controllers/wallet_controllers/add_edit_extern_card/add_edit_card_second_step_controller.dart';
import 'package:cGamer/app/data/provider/wallet_providers/wallet_provider.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class CardSecondStepBinding implements Bindings {
  @override
  void dependencies() {
    Requester apiClient = Requester();
    Get.lazyPut<AddEditCardSecondStepController>(
      () => AddEditCardSecondStepController(
        repository: CardRepository(
          apiClient: CardProvider(httpClient: apiClient),
        ),
      ),
    );
  }
}
