import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ScreenUtils {
  static void changeSystemColors(
      {Color? statusBarColor, Color? navigationColor}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: statusBarColor != null ? statusBarColor : primaryColor,
        systemNavigationBarColor:
            navigationColor != null ? navigationColor : secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
