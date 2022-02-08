import 'package:cGamer/app/controllers/profile/account_data/phone_data_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/phone_data_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/phone_data_repository.dart';

class PhoneDataBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    PhoneDataApiClient _apiClient = PhoneDataApiClient(httpClient: client);
    Get.lazyPut<PhoneDataController>(
      () => PhoneDataController(
          repository: PhoneDataRepository(apiClient: _apiClient)),
    );
  }
}
