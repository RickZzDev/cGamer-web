import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class PlayWinTropyCard extends StatelessWidget {
  final String? text;
  final String? description;
  final Function()? onTap;
  final bool hasBorder;
  final bool containsCounter;
  final String? buttonTitle;
  final int? timestamp;
  final bool isPrime;
  final bool isBenefitsPrime;
  const PlayWinTropyCard(
      {Key? key,
      this.hasBorder = false,
      this.description,
      this.buttonTitle,
      this.containsCounter = false,
      this.timestamp,
      this.isPrime = false,
      this.isBenefitsPrime = false,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: containsCounter ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: hasBorder
                  ? BorderSide(color: primaryColor, width: 0.5)
                  : BorderSide.none),
        ),
        padding: EdgeInsets.only(left: screenWidthhSize * 0.01),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            text ?? "",
                            style: textStyle.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          isBenefitsPrime
                              ? isPrime
                                  ? Container(
                                      margin: EdgeInsets.only(left: 4),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF131313),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Text('50% do tempo',
                                          style:
                                              textStyle.copyWith(fontSize: 12)))
                                  : Container()
                              : Container()
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      description != null
                          ? Text(
                              description ?? "",
                              style: textStyle.copyWith(
                                fontSize: 13,
                                color: Colors.white54,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 2,
                      ),
                    ]),
              ],
            ),
            containsCounter && timestamp != null
                ? CountdownTimer(
                    endTime: timestamp,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return GestureDetector(
                            onTap: containsCounter ? onTap : null,
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Text(
                                buttonTitle ?? "",
                                style: textStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                            ));
                      }
                      return Container(
                          child: Text(
                              time.sec! < 10
                                  ? '${time.min ?? 0}:0${time.sec}'
                                  : '${time.min ?? 0}:${time.sec}',
                              style: textStyle.copyWith(
                                  fontSize: 24,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)));
                    },
                  )
                : GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Text(
                        buttonTitle ?? "",
                        style: textStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                    ))
          ],
        ),
      ),
    );
  }
}
