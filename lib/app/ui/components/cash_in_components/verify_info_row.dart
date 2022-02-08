import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyInfoRow extends StatelessWidget {
  final String infoName;
  final String? info;
  final Color? color;
  final bool bottomBorder;
  final Widget? widgetAction;
  final bool noBorder;
  final bool jumpLine;

  const VerifyInfoRow(
      {Key? key,
      required this.infoName,
      required this.info,
      this.color,
      this.widgetAction,
      this.noBorder = false,
      this.bottomBorder = false,
      this.jumpLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        border: noBorder
            ? Border()
            : Border(
                top: bottomBorder
                    ? BorderSide(color: Colors.transparent)
                    : BorderSide(
                        color: color ?? utils.secondaryColor,
                      ),
                bottom: bottomBorder
                    ? BorderSide(
                        color: color ?? utils.secondaryColor,
                      )
                    : BorderSide(color: Colors.transparent),
              ),
      ),
      child: jumpLine
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  infoName,
                  style: utils.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color == null ? utils.secondaryColor : color),
                ),
                SizedBox(
                  height: 4,
                ),
                widgetAction ??
                    Text(
                      info ?? "",
                      style: utils.textStyle.copyWith(
                        color: color == null ? utils.secondaryColor : color,
                        fontSize: 16,
                      ),
                    )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  infoName,
                  style: utils.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color == null ? utils.secondaryColor : color),
                ),
                widgetAction ??
                    Flexible(
                      child: Text(
                        info ?? "",
                        style: utils.textStyle.copyWith(
                          color: color == null ? utils.secondaryColor : color,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
              ],
            ),
    );
  }
}
