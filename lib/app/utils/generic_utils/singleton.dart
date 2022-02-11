import 'dart:ui';

import 'package:cGamer/app/utils/extensions/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Singleton {
  static Singleton? _instance;
  factory Singleton(
      {int teamId = -1,
      String teamName = "Default Name",
      String teamImageURL = "",
      String hexPrimaryColor = "",
      String hexSecondaryColor = "",
      String teamToken = "",
      String oneSignalAppId = "",
      String appName = "",
      String urlDownloadApp = "",
      String socialNetwork = "",
      String urlBuyPlayWeb = ""}) {
    _instance ??= Singleton._internalConstructor(
        teamId,
        teamName,
        teamImageURL,
        hexPrimaryColor,
        hexSecondaryColor,
        teamToken,
        oneSignalAppId,
        appName,
        urlDownloadApp,
        socialNetwork,
        urlBuyPlayWeb);

    return _instance!;
  }
  Singleton._internalConstructor(
      this.teamId,
      this.teamName,
      this.teamImageURL,
      hexPrimaryColor,
      hexSecondaryColor,
      this.teamToken,
      this.oneSignalAppId,
      this.appName,
      this.urlDownloadApp,
      this.socialNetwork,
      this.urlBuyPlayWeb) {
    primaryColor = HexColor.fromHex(hexPrimaryColor);
    secondaryColor = HexColor.fromHex(hexSecondaryColor);
  }

  int? teamId;
  String? teamName;
  String? teamImageURL;
  Color? primaryColor;
  Color? secondaryColor;
  String? teamToken;
  String? oneSignalAppId;
  String? appName;
  String? urlDownloadApp;
  String? socialNetwork;
  String? urlBuyPlayWeb;
}
