import 'dart:convert';

import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

abstract class SecurityUtils {
  static LocalAuthentication auth = LocalAuthentication();

  static Future<bool> isActivatedFaceId() async {
    String value = await CacheUtils.readValue(key: 'faceId-bio-activated');
    if (value == null) {
      return false;
    }
    return true;
  }

  static Future<bool> checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    return canCheckBiometrics;
  }

  static Future<List<BiometricType>?> getAvailableBiometrics() async {
    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    return availableBiometrics;
  }

  static Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          androidAuthStrings: AndroidAuthMessages(
              cancelButton: "Cancelar", signInTitle: "Jogga Bank"),
          localizedReason: 'Autentique-se com seu FaceID ou Biometria',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    return authenticated;
  }

  static void cancelAuthentication() {
    auth.stopAuthentication();
  }

  static String encodeTo64(String _value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String _enconded = stringToBase64.encode(_value);
    return _enconded;
  }

  static String decodeFrom64(String _value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String _decoded = stringToBase64.decode(_value);
    return _decoded;
  }
}
