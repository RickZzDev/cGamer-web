import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CupertinoRemoveCardAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Tem certeza que deseja excluir o cartão final 0123?"),
      actions: [
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              "Cancelar",
              style: textStyle.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              "Excluir",
              style: textStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
