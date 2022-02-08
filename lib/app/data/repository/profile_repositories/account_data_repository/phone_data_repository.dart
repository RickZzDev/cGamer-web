import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/phone_data_provider.dart';
import 'package:meta/meta.dart';

class PhoneDataRepository {
  final PhoneDataApiClient apiClient;

  PhoneDataRepository({required this.apiClient});

  getPhone() async {
    return await apiClient.getPhone();
  }

  update(String phone) async {
    return await apiClient.update(phone);
  }
}
