import 'package:flutter_flavor/flutter_flavor.dart';

class API {
  //DEV
  String path = "${FlavorConfig.instance.variables["baseUrl"]}";
  String getUrlComposed() {
    return path;
  }

  Uri getUriComposed(String? path, Map<String, String>? params) {
    if (FlavorConfig.instance.name == "DEV") {
      return Uri.http(
          "${FlavorConfig.instance.variables["baseUrl"]}", path ?? "", params);
    }
    return Uri.https(
        "${FlavorConfig.instance.variables["baseUrl"]}", path ?? "", params);
  }
  //PROD
  // final path = '';

  // String getURLComposed(String endpoint) {
  //   return path + endpoint;
  // }
}
