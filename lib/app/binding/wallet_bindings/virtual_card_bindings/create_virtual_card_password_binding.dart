import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/add_virtual_card_create_password_step.dart';
import 'package:cGamer/app/data/provider/wallet_providers/wallet_provider.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class VirtualCardCreatePasswordStepBinding implements Bindings {
  @override
  void dependencies() {
    Requester apiClient = Requester();
    Get.lazyPut<VirtualCardCreatePasswordController>(
      () => VirtualCardCreatePasswordController(
        repository: CardRepository(
          apiClient: CardProvider(httpClient: apiClient),
        ),
      ),
    );
  }
}
