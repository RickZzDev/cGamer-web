import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_values_controller%20.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/provider_phone_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_provider_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class PhoneRechargeValuesBinding implements Bindings {
  @override
  void dependencies() {
    Requester client = Requester();
    ProviderPhoneApiClient _apiClient =
        ProviderPhoneApiClient(httpClient: client);
    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);

    Get.lazyPut<PhoneRechargeValuesController>(
      () => PhoneRechargeValuesController(
          repository: PhoneProvidersRepository(apiClient: _apiClient),
          homeRepository: HomeRepository(apiClient: _homeApiClient)),
    );
  }
}
