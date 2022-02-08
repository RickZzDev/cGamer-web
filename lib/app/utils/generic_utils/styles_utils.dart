import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const textStyle =
    TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Exo');

var secondaryColor = Theme.of(Get.context!).accentColor;

var primaryColor = Theme.of(Get.context!).primaryColor;

var screenHeigthSize = MediaQuery.of(Get.context!).size.height;

var screenWidthhSize = MediaQuery.of(Get.context!).size.width;

var radiusTop15 = BorderRadius.only(
  topLeft: Radius.circular(15),
  topRight: Radius.circular(15),
);
