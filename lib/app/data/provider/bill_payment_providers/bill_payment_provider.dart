import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/bill_payment_endpoints/bill_payment_endpoint.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class BillPaymentApiClient {
  final http.Client httpClient;
  BillPaymentApiClient({required this.httpClient});

  validate(BillPaymentValidateModel? model) async {
    var url = BillPaymentEndpoint.validate(model?.code ?? "");
    var body = model?.toJson();
    var response = await Requester().post(
        url: url, body: body, header: await Headers().getAuthenticatedHeader());
    return response;
  }

  confirm(BillPaymentConfirmModel model) async {
    var url = BillPaymentEndpoint.confirm;
    var body = model.toJson();
    var response = await Requester().post(
        url: url, body: body, header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
