import 'package:flutter/material.dart';


abstract class KeyboardIsOpen {
 static  bool verify(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return false;
    } else {
      return true;
    }
  }
}
