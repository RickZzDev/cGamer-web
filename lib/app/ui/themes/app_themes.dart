import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(104, 203, 60, .1),
  100: Color.fromRGBO(104, 203, 60, .2),
  200: Color.fromRGBO(104, 203, 60, .3),
  300: Color.fromRGBO(104, 203, 60, .4),
  400: Color.fromRGBO(104, 203, 60, .5),
  500: Color.fromRGBO(104, 203, 60, .6),
  600: Color.fromRGBO(104, 203, 60, .7),
  700: Color.fromRGBO(104, 203, 60, .8),
  800: Color.fromRGBO(104, 203, 60, .9),
  900: Color.fromRGBO(104, 203, 60, 1),
};

//MaterialColor primaryColorMaterial = MaterialColor(0xFF68CB3C, color);
MaterialColor primaryColorMaterial = MaterialColor(0xFF01CC23, color);
MaterialColor secondaryColorMaterial = MaterialColor(0xFF25475F, color);
final ThemeData appThemeData = ThemeData(
    primarySwatch: primaryColorMaterial,
    primaryColor: primaryColorMaterial,
    buttonColor: primaryColorMaterial,
    brightness: Brightness.light,
    accentColor: secondaryColorMaterial,
    appBarTheme: AppBarTheme(color: secondaryColorMaterial)

    // appBarTheme: AppBarTheme(color: Colors.green),
    );

final ThemeData appThemeDataDark = ThemeData(
    // primarySwatch: Colors.purple,
    // primaryColor: Colors.purple,
    // buttonColor: Colors.black,
    // brightness: Brightness.dark,
    // accentColor: Colors.cyan[600],
    // appBarTheme: AppBarTheme(color: Colors.black),
    );
