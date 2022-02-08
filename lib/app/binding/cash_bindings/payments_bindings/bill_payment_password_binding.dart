import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/password_controller.dart';
import 'package:cGamer/app/data/provider/bill_payment_providers/bill_payment_provider.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BillPaymentPasswordBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    BillPaymentApiClient apiClient = BillPaymentApiClient(httpClient: client);
    Get.lazyPut<BillPaymentPasswordController>(
      () => BillPaymentPasswordController(
        repository: BillPaymentRepository(apiClient: apiClient),
      ),
    );
  }
}
