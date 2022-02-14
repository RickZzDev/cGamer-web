import 'package:cGamer/app/controllers/cash_actions_controllers/deposit_value_in_out/deposit_value_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class DepositValueBinding implements Bindings {
  @override
  void dependencies() {
    Requester httpClient = Requester();
    HomeApiClient apiClient = HomeApiClient(httpClient: httpClient);
    Get.lazyPut<DepositValueController>(
      () => DepositValueController(
        repository: HomeRepository(apiClient: apiClient),
      ),
    );
  }
}
