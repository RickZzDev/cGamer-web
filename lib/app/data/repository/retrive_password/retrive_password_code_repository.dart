import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_code_provider.dart';
import 'package:meta/meta.dart';

class RetrivePasswordCodeRepository {

final RetrivePasswordCodeApiClient apiClient;

RetrivePasswordCodeRepository({required this.apiClient});

Future<dynamic> validateCode(String email, String code) async {
  return await apiClient.validateCode(email, code);
}

}