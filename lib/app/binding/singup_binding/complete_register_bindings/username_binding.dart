import 'package:cGamer/app/controllers/signup/complete_register/username_step_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/username_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/username_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsernameBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    UsernameApiClient _apiClient = UsernameApiClient(httpClient: client);
    Get.lazyPut<UsernameStepController>(() => UsernameStepController(
        repository: UsernameRepository(apiClient: _apiClient)));
  }
}
