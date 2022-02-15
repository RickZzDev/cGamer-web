import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressedFunction;
  final Color? txtColor;
  final Color? color;
  final bool haveToReturnContext;
  final double height;
  final double? txtSize;
  final Widget? rightIcon;
  final bool enabled;
  final bool isTransparentButton;

  GenericButton(
      {required this.text,
      this.icon,
      required this.onPressedFunction,
      this.color,
      this.txtColor,
      this.txtSize,
      this.haveToReturnContext = false,
      this.height = 44,
      this.isTransparentButton = false,
      this.enabled = true,
      this.rightIcon});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressedFunction == null
            ? null
            : () => haveToReturnContext
                ? onPressedFunction!(context)
                : onPressedFunction!(),
        style: ElevatedButton.styleFrom(
          elevation: isTransparentButton ? 0 : null,
          side: isTransparentButton
              ? BorderSide(color: primaryColor)
              : BorderSide.none,
          primary: !enabled
              ? Colors.blueGrey
              : color == null
                  ? isTransparentButton
                      ? Colors.transparent
                      : Theme.of(context).primaryColor
                  : color,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    child: Icon(
                      icon,
                      color: txtColor != null ? txtColor : Colors.black,
                      size: 20,
                    ),
                  )
                : SizedBox(),
            Text(
              " $text",
              style: TextStyle(
                  color: txtColor != null ? txtColor : Colors.black,
                  fontSize: txtSize != null ? txtSize : 14),
            ),
            rightIcon != null ? rightIcon! : SizedBox()
          ],
        ),
      ),
    );
  }
}
