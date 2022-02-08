import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class CategoryGamesProvider {
  final http.Client httpClient;
  CategoryGamesProvider({required this.httpClient});

  // auth(String cpf, String password) async {
  //   var url = AuthEndpoints().authEndpoint;

  //   var body = AuthRequestModel(cpf: cpf, password: password).toJson();
  //   var response = await Requester().post(url: url, body: body);

  //   return response;
  // }
}
