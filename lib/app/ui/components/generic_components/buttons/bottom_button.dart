import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String txt;
  final Function() onTap;
  BottomButton({Key? key, required this.txt, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GenericButton(
            text: txt,
            onPressedFunction: onTap,
            txtColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
