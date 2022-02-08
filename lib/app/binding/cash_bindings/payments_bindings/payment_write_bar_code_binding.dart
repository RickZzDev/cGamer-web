import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/write_bar_code_controller.dart';
import 'package:cGamer/app/data/provider/bill_payment_providers/bill_payment_provider.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WriteBarCodeBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    BillPaymentApiClient _apiClient = BillPaymentApiClient(httpClient: client);
    Get.lazyPut<WriteBarCodeController>(
      () => WriteBarCodeController(
        repository: BillPaymentRepository(apiClient: _apiClient),
      ),
    );
  }
}
