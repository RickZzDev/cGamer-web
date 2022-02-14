import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/ted_intern_success_controller.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_intern_provider.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class SuccessTransferBinding implements Bindings {
  @override
  void dependencies() {
    Requester httpClient = Requester();
    Get.lazyPut<TransferConfirmSuccessController>(
      () => TransferConfirmSuccessController(
        repository: TransferInterRepository(
          apiClient: TransferInterApiClient(httpClient: httpClient),
        ),
      ),
    );
  }
}
