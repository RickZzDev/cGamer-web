import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class FutureUtils {
  static verifyFutureState(
      AsyncSnapshot<List<dynamic>> snapshot, RxBool _varToReceiveValue) {
    if (snapshot.hasData) {
      for (var a in snapshot.data!) {
        if (a == false) {
          return false;
        }
      }
      _varToReceiveValue.value = true;
      _varToReceiveValue.refresh();
      return true;
    }
    return false;
  }
}
