import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String? txt;
  final Icon? icon;
  final Function()? onTap;
  CardButton({
    required this.txt,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 65,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: primaryColor),
        ),
        padding: EdgeInsets.only(right: 0, left: 0),
        color: secondaryColor,
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(),
            SizedBox(
              height: 4,
            ),
            Text(
              txt ?? "",
              style: textStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
