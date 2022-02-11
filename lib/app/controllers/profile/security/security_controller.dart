import 'dart:io';

import 'package:get/get.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:local_auth/local_auth.dart';

class SecurityController extends GetxController {
  final switchValue = false.obs;

  @override
  void onReady() async {
    switchValue.value = await SecurityUtils.isActivatedFaceId();
    super.onReady();
  }

  void onChangedSwitch(bool value) async {
    bool authenticated = false;
    if (Platform.isAndroid) {
      bool canCheckBiometrics = await SecurityUtils.checkBiometrics();
      if (canCheckBiometrics) {
        List<BiometricType>? availableBiometrics =
            await SecurityUtils.getAvailableBiometrics();
        int length = availableBiometrics?.length ?? 0;
        if (length > 0) {
          authenticated = await SecurityUtils.authenticate();
        }
      }
    } else {
      authenticated = await SecurityUtils.authenticate();
    }

    if (authenticated) {
      switchValue.value = value;
      CacheUtils.addToCache(
          key: 'faceId-bio-activated', value: value ? "ON" : null);
    } else {
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: "Não foi possível lhe identificar para ativar essa opção!");
    }
  }
}
