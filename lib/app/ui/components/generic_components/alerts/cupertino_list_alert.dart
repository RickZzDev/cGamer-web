import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/alerts/cupertino_remove_card_alert.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CupertinoListAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("O que você quer fazer?"),

      // content: Text("Tem certeza que deseja bloquear o cartão virtual?"),
      actions: [
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Text(
              "Definir como principal",
              style: textStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => {
              Get.back(),
              Get.toNamed(Routes.WALLET_EXTERN_CARD_FIRST_INFO),
            },
            child: Text(
              "Editar",
              style: textStyle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        CupertinoDialogAction(
          child: GestureDetector(
            onTap: () => {
              Get.back(),
              showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) => CupertinoRemoveCardAlert(),
              ),
            },
            child: Text(
              "Excluir cartão",
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
              "Cancelar",
              style: textStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
