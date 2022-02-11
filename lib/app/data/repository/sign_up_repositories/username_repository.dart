import 'package:cGamer/app/data/provider/signup_providerrs/username_provider.dart';
import 'package:meta/meta.dart';

class UsernameRepository {
  final UsernameApiClient apiClient;

  UsernameRepository({required this.apiClient});

  Future<dynamic> verify(String username) async {
    var response = await apiClient.verify(username);
    return response;
  }
}
