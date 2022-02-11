import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class FilterDialogGridItem extends StatelessWidget {
  final String title;
  final int index;
  final int atualChoose;
  final Function() onTap;

  FilterDialogGridItem(
      {required this.title,
      required this.index,
      required this.atualChoose,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: index == atualChoose ? primaryColor : Colors.transparent,
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          title,
          style: textStyle.copyWith(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
