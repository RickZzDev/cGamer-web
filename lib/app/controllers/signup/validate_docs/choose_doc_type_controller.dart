import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseDocTypeController extends GetxController {
  final docSelected = "".obs;
  final colorRG = Theme.of(Get.context!).accentColor.obs;
  final colorCNH = Theme.of(Get.context!).accentColor.obs;

  Color primaryColor() => Theme.of(Get.context!).primaryColor;

  Color secondaryColor() => Theme.of(Get.context!).accentColor;

  clickDoc(String _origin) {
    docSelected.value = _origin;
    checkBackgroundColor();
  }

  Color checkIconColor(String _origin) {
    if (docSelected.value == "") return Theme.of(Get.context!).primaryColor;
    if (_origin == "rg") {
      if (docSelected.value == "RG")
        return secondaryColor();
      else
        return primaryColor();
    } else {
      if (docSelected.value == "CNH")
        return secondaryColor();
      else
        return primaryColor();
    }
  }

  checkBackgroundColor() {
    if (docSelected.value == "RG") {
      colorCNH.value = secondaryColor();
      colorRG.value = primaryColor();
    } else if (docSelected.value == "CNH") {
      colorCNH.value = primaryColor();
      colorRG.value = secondaryColor();
    }
  }

  changepage() {
    if (docSelected.value == "")
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: "É necessário escolher um tipo de documento para ser validado");
    else
      Get.toNamed(Routes.VALIDATE_DOCS_TIPS,
          arguments: {"doc_type": docSelected.value});
  }
}
