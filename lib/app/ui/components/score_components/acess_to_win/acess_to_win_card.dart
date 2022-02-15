import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class AcessToWinCard extends StatelessWidget {
  AcessToWinCard(
      {required this.dayCount,
      required this.moreScore,
      this.hasCompleted = false,
      this.currentDay,
      this.onTap});

  final String dayCount;
  final String moreScore;
  final bool hasCompleted;
  final bool? currentDay;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return currentDay != null
        ? GestureDetector(
            onTap: onTap ?? null,
            child: Container(
              decoration: BoxDecoration(
                color: hasCompleted ? primaryColor : secondaryColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(2, 4.0), //(x,y)
                    blurRadius: 2.0,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: primaryColor),
                    height: 30,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          dayCount,
                          style: textStyle.copyWith(
                              color: secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  hasCompleted
                      ? Container(
                          width: double.infinity,
                          height: 1,
                          color: secondaryColor,
                        )
                      : Container(),
                  Expanded(
                      child: Container(
                          child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                        Text(
                          '+$moreScore',
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color:
                                  hasCompleted ? secondaryColor : Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          'assets/images/gamification_icons/cristal.png',
                          height: 24,
                          width: 24,
                        ),
                      ])))),
                  hasCompleted
                      ? Container(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Icons.check,
                            color: Theme.of(context).accentColor,
                            size: 30,
                          ))
                      : Padding(
                          padding:
                              EdgeInsets.only(left: 4, right: 4, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32)),
                                    border: Border.all(
                                        color: primaryColor, width: 1),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Check-in',
                                style: textStyle.copyWith(
                                    fontSize: 13, color: primaryColor),
                              )
                            ],
                          ))
                ],
              ),
            ))
        : Container(
            decoration: BoxDecoration(
              color: hasCompleted ? primaryColor : secondaryColor,
              border: Border.all(color: Color(0xFFF2F2F2)),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(2, 4.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Color(0xFFF2F2F2)),
                  height: 30,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        dayCount,
                        style: textStyle.copyWith(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                ),
                hasCompleted
                    ? Container(
                        width: double.infinity,
                        height: 1,
                        color: secondaryColor,
                      )
                    : Container(),
                Expanded(
                    child: Container(
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                      Text(
                        '+$moreScore',
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: hasCompleted
                                ? secondaryColor
                                : Color(0xFFF2F2F2)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        'assets/images/gamification_icons/cristal.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ])))),
                hasCompleted
                    ? Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        ))
                    : Container()
                // Padding(
                //     padding: EdgeInsets.only(left: 4, right: 4, bottom: 4),
                //     child: GenericButton(
                //         height: 30,
                //         text: 'Resgatar',
                //         color: primaryColor,
                //         txtColor: secondaryColor,
                //         txtSize: 13,
                //         onPressedFunction: onTap))
              ],
            ),
          );
  }
}
