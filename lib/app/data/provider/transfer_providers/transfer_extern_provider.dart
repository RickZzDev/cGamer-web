import 'package:cGamer/app/utils/api_utils/endpoints/transfer_endpoints/transfer_extern_endpoint.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';

class TransferExternApiClient {
  final Requester httpClient;
  TransferExternApiClient({required this.httpClient});

  getContacts() async {
    var response = await httpClient.fetch(
      url: TransferExternEdnpoints.contacts(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getBanks() async {
    var response = await httpClient.fetch(
      url: TransferExternEdnpoints.getBanks(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  sendTransfer(Map<String, dynamic> json) async {
    var response = await httpClient.post(
        url: TransferExternEdnpoints.transfer(),
        header: await Headers().getAuthenticatedHeader(),
        body: json);
    return response;
  }

  saveContact(Map<String, dynamic> jsonValue) async {
    var response = await httpClient.post(
        url: TransferExternEdnpoints.saveContact(),
        header: await Headers().getAuthenticatedHeader(),
        body: jsonValue);
    return response;
  }
}
