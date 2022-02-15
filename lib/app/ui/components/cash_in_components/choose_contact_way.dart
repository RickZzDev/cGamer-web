import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChosseContactWay extends StatelessWidget {
  final Function onTap;
  final String txt;
  const ChosseContactWay({
    Key? key,
    required this.onTap,
    required this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60,
        width: utils.screenWidthhSize * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: utils.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(1, 2.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          border: Border.all(
            color: utils.primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: utils.textStyle
                .copyWith(color: utils.primaryColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
