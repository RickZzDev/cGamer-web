import 'package:cGamer/app/data/provider/login_provider/auth_provider.dart';
import 'package:meta/meta.dart';

class AuthRepository {
  final AuthApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<dynamic> auth(String cpf, String password) async {
    try {
      return await apiClient.auth(cpf, password);
    } catch (e) {
      rethrow;
    }
  }
}
