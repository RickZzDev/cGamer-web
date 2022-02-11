import 'package:cGamer/app/controllers/login/retrive_password/retrive_password_code_controller.dart';
import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_code_provider.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_code_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RetrivePasswordCodeBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    RetrivePasswordCodeApiClient _apiClient = RetrivePasswordCodeApiClient(httpClient: client);
    Get.lazyPut<RetrivePasswordCodeController>(
      () => RetrivePasswordCodeController(
        repository: RetrivePasswordCodeRepository(apiClient: _apiClient),
      ),
    );
  }
}
