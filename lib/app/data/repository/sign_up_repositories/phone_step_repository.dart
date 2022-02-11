import 'package:cGamer/app/data/provider/signup_providerrs/phone_step_provider.dart';
import 'package:meta/meta.dart';

class PhoneStepRepository {
  final PhoneStepApiClient apiClient;

  PhoneStepRepository({required this.apiClient});

  sendSmsCode(String _phone) async => await apiClient.sendSmsCode(_phone);
}
