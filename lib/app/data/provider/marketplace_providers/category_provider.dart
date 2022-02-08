import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class CategoryProvider {
  final http.Client httpClient;
  CategoryProvider({required this.httpClient});

  // auth(String cpf, String password) async {
  //   var url = AuthEndpoints().authEndpoint;

  //   var body = AuthRequestModel(cpf: cpf, password: password).toJson();
  //   var response = await Requester().post(url: url, body: body);

  //   return response;
  // }
}
