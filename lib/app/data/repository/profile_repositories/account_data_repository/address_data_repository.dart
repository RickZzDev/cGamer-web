import 'package:cGamer/app/data/models/complete_register/adress_models/cep_model.dart';
import 'package:cGamer/app/data/provider/profile_provider/account_data_provider/address_data_provider.dart';
import 'package:meta/meta.dart';

class AddressDataRepository {
  final AddressDataApiClient apiClient;

  AddressDataRepository({required this.apiClient});

  getAddress() async {
    return await apiClient.getAddress();
  }

  update(CepModel model) async {
    return await apiClient.update(model);
  }
}
