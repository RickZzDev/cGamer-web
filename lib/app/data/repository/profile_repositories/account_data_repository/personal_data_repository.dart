import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/personal_data_provider.dart';
import 'package:meta/meta.dart';

class PersonalDataRepository {
  final PersonalDataApiClient apiClient;

  PersonalDataRepository({required this.apiClient});

  getData() async {
    return await apiClient.getProfile();
  }

  update(ProfileModel model) async {
    return await apiClient.update(model);
  }
}
