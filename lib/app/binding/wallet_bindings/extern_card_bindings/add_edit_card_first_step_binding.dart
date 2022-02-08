import 'package:cGamer/app/controllers/wallet_controllers/add_edit_extern_card/add_edit_card_first_step_controller.dart';
import 'package:cGamer/app/data/provider/wallet_providers/wallet_provider.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ExternCardFirstStepBinding implements Bindings {
  @override
  void dependencies() {
    Requester apiCient = Requester();

    Get.lazyPut<AddEditExternCardFirstStepController>(
      () => AddEditExternCardFirstStepController(
        repository: CardRepository(
          apiClient: CardProvider(httpClient: apiCient),
        ),
      ),
    );
  }
}
