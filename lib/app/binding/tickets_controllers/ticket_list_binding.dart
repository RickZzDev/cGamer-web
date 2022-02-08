import 'package:cGamer/app/controllers/cash_actions_controllers//ticket_list_view/ticket_list_controller.dart';
import 'package:cGamer/app/data/provider/bankslip/bankslip_provider.dart';
import 'package:cGamer/app/data/repository/bankslip_repositories/bankslip_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class TicketListBinding implements Bindings {
  @override
  void dependencies() {
    final _requester = Requester();
    BankSlipApiClient _apiClient = BankSlipApiClient(httpClient: _requester);

    Get.lazyPut<TicketListController>(
      () => TicketListController(
        repository: BankSliptRepository(apiClient: _apiClient),
      ),
    );
  }
}
