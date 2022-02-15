import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/recharge_phone_endpoints/recharge_phone_endpoints.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class RechargePhoneContactsApiClient {
  final http.Client httpClient;
  RechargePhoneContactsApiClient({required this.httpClient});

  saveContact(PhoneContact contact) async {
    var url = RechargePhoneEndpoints().contacts;
    var body = contact.toJson();
    var response = await Requester().post(
        url: url, body: body, header: await Headers().getAuthenticatedHeader());
    return response;
  }

  getContacts() async {
    var url = RechargePhoneEndpoints().contacts;
    var response = await Requester()
        .fetch(url: url, header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
