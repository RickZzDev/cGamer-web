import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagPrime extends StatelessWidget {
  TagPrime({transform, fontSize})
      : this._transform = transform,
        this._fontSize = fontSize ?? 14;

  final Matrix4? _transform;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        transform: _transform,
        decoration: BoxDecoration(
            color: Color(0xFF131313),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          "PRIME",
          style: textStyle.copyWith(
              fontSize: _fontSize,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold),
        ));
  }
}
