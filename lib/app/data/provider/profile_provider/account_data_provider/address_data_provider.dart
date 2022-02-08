import 'package:cGamer/app/data/models/complete_register/adress_models/cep_model.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/endpoints/endpoints_export.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class AddressDataApiClient {
  final http.Client httpClient;
  AddressDataApiClient({required this.httpClient});

  getAddress() async {
    var response = await Requester().fetch(
        url: AccountDataEndpoint.getAddress,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }

  update(CepModel model) async {
    var body = model.toJson();
    // var url = AccountDataEndpoint.getAddress +
    // "?district=${model.bairro}?city=${model.localidade}&cep=${model.cep}&number=${model.number}&address=${model.logradouro}&state=${model.uf}&complement=${model.complemento}";
    var response = await Requester().put(
        url: AccountDataEndpoint.getAddress,
        body: body,
        header: await Headers().getAuthenticatedHeader());
    return response;
  }
}
