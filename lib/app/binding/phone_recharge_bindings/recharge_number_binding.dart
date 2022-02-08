import 'package:cGamer/app/controllers/recharge_phone/recharge_number_controller.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/recharge_phone_provider.dart';
import 'package:cGamer/app/data/repository/recharge_phone/recharge_phone_contacts_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RechargeNumberBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    RechargePhoneContactsApiClient _apiClient =
        RechargePhoneContactsApiClient(httpClient: client);
    Get.lazyPut<RechargeNumberController>(
      () => RechargeNumberController(
        repository: RechargePhoneContactsRepository(apiClient: _apiClient),
      ),
    );
  }
}
