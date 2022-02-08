import 'package:cGamer/app/controllers/recharge_phone/phone_recharge_password_controller.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/phone_recharge_password_provider.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_recharge_password_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PhoneRechargePasswordBinding implements Bindings {
  @override
  void dependencies() {
    http.Client client = http.Client();
    PhoneRechargePasswordApiClient _apiClient =
        PhoneRechargePasswordApiClient(httpClient: client);
    Get.lazyPut<PhoneRechargePasswordController>(
      () => PhoneRechargePasswordController(
        repository: RechargePhonePasswordRepository(apiClient: _apiClient),
      ),
    );
  }
}
