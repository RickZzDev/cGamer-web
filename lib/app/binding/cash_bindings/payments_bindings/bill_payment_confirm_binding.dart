import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/confirm_payment.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class ConfirmBillPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Requester httpClient = Requester();
    HomeApiClient apiClient = HomeApiClient(httpClient: httpClient);
    Get.lazyPut<ConfirmBillPaymentController>(
      () => ConfirmBillPaymentController(
        homeRepository: HomeRepository(apiClient: apiClient),
      ),
    );
  }
}
