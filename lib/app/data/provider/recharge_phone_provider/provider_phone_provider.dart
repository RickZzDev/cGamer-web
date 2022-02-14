import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/recharge_phone_endpoints/recharge_phone_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';

class ProviderPhoneApiClient {
  final Requester httpClient;
  ProviderPhoneApiClient({required this.httpClient});

  getProviders() async {
    var url = RechargePhoneEndpoints().providers;
    var response = await Requester()
        .fetch(url: url, header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getValues(String providerId) async {
    var url = RechargePhoneEndpoints().values(providerId);
    var response = await Requester()
        .fetch(url: url, header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
