import 'package:cGamer/app/controllers/profile/account_data/personal_data_controller.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/personal_data_provider.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/personal_data_repository.dart';

class PersonalDataBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    PersonalDataApiClient _apiClient =
        PersonalDataApiClient(httpClient: client);
    Get.lazyPut<PersonalDataController>(
      () => PersonalDataController(
        repository: PersonalDataRepository(apiClient: _apiClient),
      ),
    );
  }
}
