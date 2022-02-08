import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/bar_code_controleller.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/data/provider/bill_payment_providers/bill_payment_provider.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:http/http.dart' as http;

class ReadBarCodeBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    BillPaymentApiClient _apiClient = BillPaymentApiClient(httpClient: client);
    Get.lazyPut<ReadBarCodeController>(
      () => ReadBarCodeController(
        repository: BillPaymentRepository(apiClient: _apiClient),
      ),
    );
  }
}
