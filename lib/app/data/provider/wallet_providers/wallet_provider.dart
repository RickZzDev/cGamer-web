import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/wallet_endpoints/virtual_card_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';

class CardProvider {
  final Requester httpClient;
  CardProvider({required this.httpClient});

  activateVirtualCard(VirtualCardRequestModel model) async {
    var url = VirtualCardsEndpoints.activateVirtualCard();
    var response = await httpClient.post(
      url: url,
      body: model.toJson(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getVirtualCardDetails() async {
    var url = VirtualCardsEndpoints.getCardDetails();
    var response = await httpClient.fetch(
      url: url,
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  blockVirtualCard(VirtualCardPasswordsRequestModel model) async {
    var url = VirtualCardsEndpoints.block();
    var response = await httpClient.put(
      url: url,
      body: model.toJson(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  unblockVirtualCard(VirtualCardPasswordsRequestModel model) async {
    var url = VirtualCardsEndpoints.unblock();
    var response = await httpClient.put(
      url: url,
      body: model.toJson(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  deleteVirtualCard(VirtualCardPasswordsRequestModel model) async {
    var url = VirtualCardsEndpoints.delete();
    var response = await httpClient.put(
      url: url,
      body: model.toJson(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getVirtualCardPCI(String password) async {
    var url = VirtualCardsEndpoints.getVirtualCardPCI();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = password;
    var response = await httpClient.post(
      url: url,
      body: data,
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  changePasswordVirtualCard(String accountPassword, String newPassword) async {
    var url = VirtualCardsEndpoints.changePassword();
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = newPassword;
    data['customerPassword'] = accountPassword;
    var response = await httpClient.post(
      url: url,
      body: data,
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getVirtualCardTransactions(
      {required int size,
      required String startDate,
      required String finalDate}) async {
    Map<String, String> _params = {
      'startDate': startDate,
      'finalDate': finalDate,
      'pageSize': size.toString()
    };
    var url = VirtualCardsEndpoints.urlVirtualCardTransactionsWithSize();
    var response = await httpClient.fetch(
        url: url,
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }
}
