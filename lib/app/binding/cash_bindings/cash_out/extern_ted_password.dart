import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_extern_password_controller.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_extern_provider.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_extern_repo.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class ExternPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Requester httlClient = Requester();
    Get.lazyPut<TransferExternPasswordController>(
      () => TransferExternPasswordController(
        repository: TransferExternRepository(
          apiClient: TransferExternApiClient(httpClient: httlClient),
        ),
      ),
    );
  }
}
