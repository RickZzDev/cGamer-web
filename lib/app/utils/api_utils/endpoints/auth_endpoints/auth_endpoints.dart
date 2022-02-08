import 'package:cGamer/app/utils/api_utils/api_path.dart';

class AuthEndpoints {
  static String _url = API().getUrlComposed();
  String registerEndpoint = "/customer/create";
  String authEndpoint = "/auth";
}
