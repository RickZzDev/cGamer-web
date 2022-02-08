import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final double size;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;
  const TipRow(
      {required this.text,
      required this.icon,
      this.size = 5,
      this.color = Colors.grey,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          icon,
          size: size,
          color: color,
        ),
        // Container(
        //   height: 10,
        //   width: 10,
        //   decoration: BoxDecoration(
        //     color: Colors.grey,
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(10),
        //     ),
        //   ),
        // ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            text,
            style: textStyle.copyWith(fontSize: 14),
          ),
        )
      ],
    );
  }
}
