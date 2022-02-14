import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

abstract class CacheUtils {
  static void removeCache({required String key}) async =>
      await Provider.of<GetStorage>(Get.context, listen: false)
          .write(key, null);
  // .write(key: key, value: null);

  static Future<void> addToCache(
          {required String key, required String? value}) async =>
      await Provider.of<GetStorage>(Get.context, listen: false)
          .write(key, value);

  static dynamic readValue({required String key}) async =>
      await Provider.of<GetStorage>(Get.context, listen: false).read(key);

  static Future<GetStorage> initGetStorage() async {
    await GetStorage.init('getStorage');
    return GetStorage('getStorage');
  }
}
