// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

abstract class PrimeUtils {
  static String PRIME_KEY = "PRIME_KEY";
  static void removeCache() async =>
      await Provider.of<GetStorage>(Get.context, listen: false)
          .write(PRIME_KEY, null);
  // .write(key: key, value: null);

  static Future<void> set({required bool isPrime}) async {
    String value = "NO";
    if (isPrime) {
      value = "YES";
    }
    await Provider.of<GetStorage>(Get.context, listen: false)
        .write(PRIME_KEY, value);
  }

  static Future<bool> isPrime() async {
    dynamic value = await Provider.of<GetStorage>(Get.context, listen: false)
        .read(PRIME_KEY);
    if (value == null || value == "NO") {
      return false;
    }
    return true;
  }

  static Future<GetStorage> initGetStorage() async {
    await GetStorage.init('getStorage');
    return GetStorage('getStorage');
  }
}
