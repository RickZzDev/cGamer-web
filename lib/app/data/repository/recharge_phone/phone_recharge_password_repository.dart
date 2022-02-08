import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:cGamer/app/data/provider/recharge_phone_provider/phone_recharge_password_provider.dart';
import 'package:meta/meta.dart';

class RechargePhonePasswordRepository {
  final PhoneRechargePasswordApiClient apiClient;

  RechargePhonePasswordRepository({required this.apiClient});
  
  finish(PhoneRechargeModel model) async {
    return await apiClient.finish(model);
  }
}
