import 'dart:io';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class Headers {
  static String? token;
  String? version;

  Headers() {
    token = "";
    version = "";
    // _getAppVersion();
  }

  Future<String> getToken() async {
    return await Provider.of<GetStorage>(Get.context, listen: false)
        .read('x-token');
  }

  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  Map<String, String> getBasicHeader()
      // await _getAppVersion();
      =>
      {
        // "OS": Platform.isAndroid ? "Android" : "iOS",
        "Content-Type": "application/json",
        // "Token": "",
        "App-Version": version ?? ""
      };

  Future<Map<String, String>> getAuthenticatedHeader() async {
    Map<String, String> authenticatedHeaders = {
      "X-Token": await getToken(),
      // "OS": Platform.isAndroid ? "Android" : "iOS",
      "Content-Type": "application/json",
      "App-Version": version ?? ""
    };
    return authenticatedHeaders;
  }

  Future<Map<String, String>> getAuthenticatedPDFHeader() async {
    Map<String, String> authenticatedHeaders = {
      "X-Token": await getToken(),
      // "OS": Platform.isAndroid ? "Android" : "iOS",
      "Content-Type": "application/pdf",
      "App-Version": version ?? ""
    };
    return authenticatedHeaders;
  }
}
