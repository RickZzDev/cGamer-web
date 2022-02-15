import 'package:cGamer/app/controllers/signup/complete_register/uf_city_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/adress_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UfCityBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    AdressApiClient _apiClient = AdressApiClient(httpClient: client);
    Get.lazyPut<UfCityController>(() =>
        UfCityController(repository: AdreessRepository(apiClient: _apiClient)));
  }
}
