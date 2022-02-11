import 'package:cGamer/app/utils/api_utils/endpoints/bankslip_endpoints/bankslip_endpoits.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/transfer_endpoints/transfer_extern_endpoint.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class BankSlipApiClient {
  final Requester httpClient;
  BankSlipApiClient({required this.httpClient});

  getTax() async {
    var response = await httpClient.fetch(
      url: BankSlipEndpoints.tax,
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  sendTicket(double _value) async {
    var response = await httpClient.post(
      url: BankSlipEndpoints.generateTicket(_value),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getAllTickets() async {
    var response = await httpClient.fetch(
      url: BankSlipEndpoints.ticketList(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }

  getPDF(String authenticationCode) async {
    var url = BankSlipEndpoints.pdf(authenticationCode);
    Map<String, String> header = await Headers().getAuthenticatedPDFHeader();

    var response = await httpClient.pdf(
      url: url,
      header: header,
    );
    return response;
  }

  getTedTax() async {
    var response = await httpClient.fetch(
      url: TransferExternEdnpoints.getTax(),
      header: await Headers().getAuthenticatedHeader(),
    );
    return response;
  }
}
