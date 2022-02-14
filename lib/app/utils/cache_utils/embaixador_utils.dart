// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

abstract class EmbaixadorUtils {
  static String EMBAIXADOR_KEY = "EMBAIXADOR_KEY";
  static void removeCache() async =>
      await Provider.of<GetStorage>(Get.context, listen: false)
          .write(EMBAIXADOR_KEY, null);
  // .write(key: key, value: null);

  static Future<void> set({required bool isEmbaixador}) async {
    String value = "NO";
    if (isEmbaixador) {
      value = "YES";
    }
    await Provider.of<GetStorage>(Get.context, listen: false)
        .write(EMBAIXADOR_KEY, value);
  }

  static Future<bool> isEmbaixador() async {
    dynamic value = await Provider.of<GetStorage>(Get.context, listen: false)
        .read(EMBAIXADOR_KEY);
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
