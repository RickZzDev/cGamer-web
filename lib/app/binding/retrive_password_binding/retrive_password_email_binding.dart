import 'package:cGamer/app/controllers/login/retrive_password/retrive_password_email_controller.dart';
import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_email_provider.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_email_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RetrivePasswordEmailBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    RetrivePasswordEmailApiClient _apiClient = RetrivePasswordEmailApiClient(httpClient: client);
    Get.lazyPut<RetrivePasswordEmailController>(
      () => RetrivePasswordEmailController(
        repository: RetrivePasswordEmailRepository(apiClient: _apiClient),
      ),
    );
  }
}
