import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidationIndication extends StatelessWidget {
  final String? txt;
  final bool valid;
  ValidationIndication({required this.txt, this.valid = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedDefaultTextStyle(
          style: valid
              ? TextStyle(color: Colors.green)
              : TextStyle(color: Colors.white),
          duration: Duration(milliseconds: 200),
          child: Text(
            txt ?? "",
          ),
        ),
        valid
            ? Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.close,
                color: Colors.red,
              )
      ],
    );
  }
}
