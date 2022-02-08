import 'package:cGamer/app/data/provider/recharge_phone_provider/provider_phone_provider.dart';
import 'package:meta/meta.dart';

class PhoneProvidersRepository {
  final ProviderPhoneApiClient apiClient;

  PhoneProvidersRepository({required this.apiClient});

  getProviders() async {
    return await apiClient.getProviders();
  }

  getValues(String providerId) async {
    return await apiClient.getValues(providerId);
  }
}
