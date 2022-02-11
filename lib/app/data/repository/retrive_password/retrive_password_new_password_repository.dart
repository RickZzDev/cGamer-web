import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_new_password_provider.dart';
import 'package:meta/meta.dart';

class RetrivePasswordNewPasswordRepository {

final RetrivePasswordNewPasswordApiClient apiClient;

RetrivePasswordNewPasswordRepository({required this.apiClient});

Future<dynamic> changePassword(String email, String code, String newPassword) async {
  return await apiClient.changePassword(email, code, newPassword);
}

}