import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cGamer/app/data/provider/signup_providerrs/adress_provider.dart';
import 'package:cGamer/app/controllers/signup/complete_register/cep_controller.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';

class CepBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    AdressApiClient _apiClient = AdressApiClient(httpClient: client);

    Get.lazyPut<CepController>(() =>
        CepController(repository: AdreessRepository(apiClient: _apiClient)));
  }
}
