import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class EmptyTransaction extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  EmptyTransaction({this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding != null ? padding : EdgeInsets.only(left: 16),
        child: Text(
          "Não há transações a serem mostradas.",
          style: textStyle.copyWith(fontSize: 15),
        ));
  }
}
