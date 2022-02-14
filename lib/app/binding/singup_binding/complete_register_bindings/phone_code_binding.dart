import 'package:cGamer/app/controllers/signup/complete_register/phone_code_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/phone_code_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/phone_code_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PhoneCodeBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    PhoneCodeApiClient _apiClient = PhoneCodeApiClient(httpClient: client);
    Get.lazyPut<PhoneCodeController>(() => PhoneCodeController(
        repository: PhoneCodeRepository(apiClient: _apiClient)));
  }
}
