import 'package:cGamer/app/data/provider/profile_provider/change_password_provider/change_password_proveider.dart';
import 'package:meta/meta.dart';

class ChangePasswordRepository {
  final ChangePasswordApiClient apiClient;

  ChangePasswordRepository({required this.apiClient});

  Future<dynamic> changePassword(String oldPassword, String newPassword) async {
    return await apiClient.changePassword(oldPassword, newPassword);
  }
}
