import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SnackBarUtils {
  static showSnackBar({
    required String desc,
    Color? color,
    Icon? icon,
    required String title,
  }) {
    Get.showSnackbar(
      GetBar(
        message: desc,
        backgroundColor: color == null ? Colors.redAccent : color,
        duration: Duration(seconds: 4),
        shouldIconPulse: true,
        icon: icon,

        snackStyle: SnackStyle.FLOATING,
        // borderRadius: 10,
        title: title,
      ),
    );
  }
}
