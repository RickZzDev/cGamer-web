import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_choose_bank_controller.dart';
import 'package:cGamer/app/data/provider/transfer_providers/transfer_extern_provider.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_extern_repo.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ChooseBankBinding implements Bindings {
  @override
  void dependencies() {
    Requester httpClient = Requester();

    Get.lazyPut<ChooseBankController>(
      () => ChooseBankController(
        repository: TransferExternRepository(
          apiClient: TransferExternApiClient(httpClient: httpClient),
        ),
      ),
    );
  }
}
