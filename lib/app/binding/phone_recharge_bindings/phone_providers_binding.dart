import 'package:cGamer/app/controllers/recharge_phone/phone_provider_controller.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/provider_phone_provider.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_provider_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class PhoneProvidersBinding implements Bindings {
  @override
  void dependencies() {
    Requester client = Requester();
    ProviderPhoneApiClient _apiClient =
        ProviderPhoneApiClient(httpClient: client);
    Get.lazyPut<PhoneProvidersController>(
      () => PhoneProvidersController(
        repository: PhoneProvidersRepository(apiClient: _apiClient),
      ),
    );
  }
}
