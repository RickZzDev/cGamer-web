import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_cash_in_controller.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/provider/cash_in_provider/cash_in_ted_provider.dart';
import 'package:cGamer/app/data/repository/cash_in_repositories/cash_in_ted_repository.dart';

import 'package:http/http.dart' as http;

class CashInTedBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    CashInTedApiClient _apiClient = CashInTedApiClient(httpClient: client);
    Get.lazyPut<CashInTedController>(
      () => CashInTedController(
        repository: CashInTedRepository(apiClient: _apiClient),
      ),
    );
  }
}
