import 'package:cGamer/app/data/provider/profile_provider/change_password_provider/change_password_proveider.dart';
import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_new_password_provider.dart';
import 'package:cGamer/app/data/repository/auth_register/register_repository.dart';
import 'package:cGamer/app/data/repository/profile_repositories/change_password_repository/change_password_repository.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_new_password_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:cGamer/app/controllers/signup/fisrt_register/password_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/register_provider.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    RegisterApiClient _apiClient = RegisterApiClient(httpClient: client);
    RetrivePasswordNewPasswordApiClient _retriveNewPasswordApiClient =
        RetrivePasswordNewPasswordApiClient(httpClient: client);

    ChangePasswordApiClient changePasswordApiClient =
        ChangePasswordApiClient(httpClient: client);
    Get.lazyPut<PasswordController>(
      () => PasswordController(
          repository: RegisterRepository(apiClient: _apiClient),
          retrivePasswordRepository: RetrivePasswordNewPasswordRepository(
              apiClient: _retriveNewPasswordApiClient),
          changePasswordRepository:
              ChangePasswordRepository(apiClient: changePasswordApiClient)),
    );
  }
}
