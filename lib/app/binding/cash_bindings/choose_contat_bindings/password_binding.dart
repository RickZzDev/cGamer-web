import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/password_controller.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_intern_provider.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class TransferPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Requester httpClient = Requester();
    Get.lazyPut<TransferPasswordController>(
      () => TransferPasswordController(
        repository: TransferInterRepository(
          apiClient: TransferInterApiClient(httpClient: httpClient),
        ),
      ),
    );
  }
}
