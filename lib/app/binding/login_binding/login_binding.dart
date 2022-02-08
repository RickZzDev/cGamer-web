import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cGamer/app/controllers/login/login_controller.dart';
import 'package:cGamer/app/data/provider/login_provider/auth_provider.dart';
import 'package:cGamer/app/data/repository/auth_register/auth_repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    AuthApiClient _apiClient = AuthApiClient(httpClient: client);
    Get.lazyPut<LoginController>(() =>
        LoginController(repository: AuthRepository(apiClient: _apiClient)));
  }
}
