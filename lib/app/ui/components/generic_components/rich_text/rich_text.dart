import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String normalText;
  final String normalText2;
  final String normalText3;
  final String customText;
  final String customText2;
  final String customText3;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final bool customFirst;

  CustomRichText(
      {required this.normalText,
      required this.customText,
      this.fontSize = 18,
      this.color = Colors.white,
      this.customFirst = false,
      this.customText2 = "",
      this.normalText2 = "",
      this.customText3 = "",
      this.normalText3 = "",
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return customFirst
        ? RichText(
            textAlign: textAlign,
            text: TextSpan(
              style: TextStyle(
                  fontSize: fontSize, color: color, fontFamily: 'Exo'),
              children: <TextSpan>[
                TextSpan(
                    text: "$customText ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: "$normalText",
                ),
                TextSpan(
                    text: " $customText2",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: " $normalText2",
                ),
                TextSpan(
                    text: " $customText3",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: " $normalText3",
                ),
              ],
            ),
          )
        : RichText(
            textAlign: textAlign,
            text: TextSpan(
              style: TextStyle(
                  fontSize: fontSize, color: color, fontFamily: 'Exo'),
              children: <TextSpan>[
                TextSpan(
                  text: "$normalText ",
                ),
                TextSpan(
                  text: "$customText ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "$normalText2 ",
                ),
                TextSpan(
                  text: "$customText2 ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "$normalText3 ",
                ),
                TextSpan(
                  text: "$customText3 ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }
}
