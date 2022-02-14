import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CupertinoAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Atenção!"),
      content: Text("Tem certeza que deseja bloquear o cartão virtual?"),
      actions: [
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Text("Não"),
          ),
        ),
        CupertinoDialogAction(
          child: Text("Sim"),
        ),
      ],
    );
  }
}
