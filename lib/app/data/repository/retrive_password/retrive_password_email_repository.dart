import 'package:cGamer/app/data/provider/retrive_password_providers/retrive_password_email_provider.dart';
import 'package:meta/meta.dart';

class RetrivePasswordEmailRepository {

final RetrivePasswordEmailApiClient apiClient;

RetrivePasswordEmailRepository({required this.apiClient});

Future<dynamic> sendCodeForEmail(String email) async {
  return await apiClient.sendCodeForEmail(email);
}

}