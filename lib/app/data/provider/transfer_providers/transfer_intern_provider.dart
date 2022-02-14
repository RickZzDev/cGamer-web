import 'package:cGamer/app/utils/api_utils/endpoints/transfer_endpoints/transfer_intern_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:meta/meta.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class TransferInterApiClient {
  final Requester httpClient;
  TransferInterApiClient({required this.httpClient});

  getContacts() async {
    var response = await httpClient.fetch(
      url: TransferInternEdnpoints.contacts(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getUserInfo(String _identifier) async {
    var response = await httpClient.fetch(
      url: TransferInternEdnpoints.getUserInfo(_identifier),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  sendTransfer(Map<String, dynamic> json) async {
    var response = await httpClient.post(
        url: TransferInternEdnpoints.transfer(),
        header: await Headers().getAuthenticatedHeader(),
        body: json);
    return response;
  }

  saveContact(String identifier) async {
    Map<String, String> _params = {
      'identifier': SecurityUtils.encodeTo64(identifier)
    };
    var response = await httpClient.post(
        url: TransferInternEdnpoints.saveContact(),
        header: await Headers().getAuthenticatedHeader(),
        params: _params);
    return response;
  }
}
