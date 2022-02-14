import 'package:cGamer/app/controllers/profile/account_data/address_data_controller.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/address_data_repository.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/address_data_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/adress_provider.dart';

class AddressDataBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    AddressDataApiClient _apiClient = AddressDataApiClient(httpClient: client);
    AdressApiClient _cepApiClient = AdressApiClient(httpClient: client);
    Get.lazyPut<AddressDataController>(
      () => AddressDataController(
          repository: AddressDataRepository(apiClient: _apiClient),
          cepRepository: AdreessRepository(apiClient: _cepApiClient)),
    );
  }
}
