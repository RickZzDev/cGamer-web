import 'package:cGamer/app/controllers/signup/complete_register/phone_step_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/phone_step_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/phone_step_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PhoneStepBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    PhoneStepApiClient _apiClient = PhoneStepApiClient(httpClient: client);
    Get.lazyPut<PhoneStepController>(() => PhoneStepController(
        repository: PhoneStepRepository(apiClient: _apiClient)));
  }
}
