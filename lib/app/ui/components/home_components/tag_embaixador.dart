import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagEmbaixador extends StatelessWidget {
  TagEmbaixador({transform, fontSize, isFull})
      : this._transform = transform,
        this._fontSize = fontSize ?? 14,
        this._isFull = isFull ?? false;

  final Matrix4? _transform;
  final double _fontSize;
  final bool _isFull;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        transform: _transform,
        decoration: BoxDecoration(
            color: Color(0xff925DF0),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          _isFull ? "EMBAIXADOR" : "EBX",
          style: textStyle.copyWith(
              fontSize: _fontSize,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold),
        ));
  }
}
