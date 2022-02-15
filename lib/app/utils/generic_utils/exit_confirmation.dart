import 'dart:io';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

abstract class ExitConfirmation {
  static Future<bool>? exitConfirmation(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Não",
        style: textStyle.copyWith(
            color: secondaryColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Sim",
        style: textStyle.copyWith(color: secondaryColor),
      ),
      onPressed: () {
        exit(0);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text("Deseja realmente sair do aplicativo?",
          style: textStyle.copyWith(color: secondaryColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
