import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/recharge_phone_endpoints/recharge_phone_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class PhoneRechargePasswordApiClient {
  final http.Client httpClient;
  PhoneRechargePasswordApiClient({required this.httpClient});

  finish(PhoneRechargeModel model) async {
    var url = RechargePhoneEndpoints().finish;
    var body = model.toJson();
    var response = await Requester().post(
        url: url, body: body, header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
