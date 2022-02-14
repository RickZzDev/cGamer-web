import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowSettingsOption extends StatelessWidget {
  final String? txt;
  final Icon? icon;
  final bool onlyBottomBorder;
  RowSettingsOption({
    required this.txt,
    required this.icon,
    this.onlyBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.white),
            top: onlyBottomBorder
                ? BorderSide(width: 0)
                : BorderSide(color: Colors.white)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt ?? "",
            style: textStyle,
          ),
          icon ?? Container()
        ],
      ),
    );
  }
}
