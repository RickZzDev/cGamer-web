import 'package:cGamer/app/controllers/signup/validate_docs/selfie_controller.dart';
import 'package:cGamer/app/data/provider/signup_providerrs/selfie_provider.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/selfie_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SelfieBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    SelfieApiClient _apiClient = SelfieApiClient(httpClient: client);
    Get.lazyPut<SelfieController>(() =>
        SelfieController(repository: SelfieRepository(apiClient: _apiClient)));
  }
}
