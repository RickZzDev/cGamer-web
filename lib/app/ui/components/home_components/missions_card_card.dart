import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompleteDataCard extends StatelessWidget {
  final String normalTxt;
  final String boldedTxt;
  final String ptsTxt;
  final Widget? widget;
  final bool status;
  final bool waiting;
  final bool reproved;
  final Function()? onTapFunction;
  CompleteDataCard(
      {this.normalTxt = "",
      this.boldedTxt = "",
      this.ptsTxt = "",
      this.status = true,
      this.onTapFunction,
      this.widget,
      this.reproved = false,
      this.waiting = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 80,
        padding: EdgeInsets.only(top: 4, left: 8, right: 10, bottom: 4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(1, 2.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          color: status || reproved
              ? Theme.of(context).accentColor
              : Color(0xFFE1E1E1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.15,
              child: widget,
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    normalTxt + " " + boldedTxt,
                    maxLines: 2,
                    minFontSize: 12,
                    maxFontSize: 14,
                    textAlign: TextAlign.left,
                    style: textStyle.copyWith(
                      color: status || reproved
                          ? Colors.white
                          : Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  reproved || waiting
                      ? Text(
                          ptsTxt,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: waiting
                                ? Colors.amberAccent
                                : reproved
                                    ? Colors.redAccent
                                    : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Row(
                          children: [
                            Image.asset(
                              'assets/images/gamification_icons/cristal.png',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              ptsTxt,
                              style: textStyle.copyWith(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
