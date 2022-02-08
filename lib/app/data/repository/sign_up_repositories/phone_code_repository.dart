import 'package:cGamer/app/data/provider/signup_providerrs/phone_code_provider.dart';
import 'package:meta/meta.dart';

class PhoneCodeRepository {
  final PhoneCodeApiClient apiClient;

  PhoneCodeRepository({required this.apiClient});

  sendSmsCode(String _phone) async => await apiClient.sendSmsCode(_phone);

  sendCompleteRegister(Map<String, dynamic> _body) async =>
      await apiClient.sendCompleteRegister(_body);
}
