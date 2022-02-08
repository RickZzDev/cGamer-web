import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PointsPendentItem extends StatelessWidget {
  final String? title;
  final String? status;
  final String? date;
  final String? amount;
  final bool isLast;

  PointsPendentItem({
    Key? key,
    required this.title,
    required this.status,
    required this.date,
    required this.amount,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 90,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    width: 0.5,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/images/gamification_icons/Pontos_Entrada.svg',
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: isLast ? Colors.transparent : Colors.white,
                    width: 0.5,
                    height: 35,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                // width: screenWidthhSize - 70,
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: amount != null && amount != "null" ? 0 : 8,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title ?? "",
                            textAlign: TextAlign.start,
                            style: textStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 16),
                              child: Text(
                                date ?? "",
                                style: textStyle.copyWith(
                                  fontSize: 14,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      status ?? "",
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: amount != null && amount != "null" ? 14 : 15,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(children: [
                      Image.asset(
                        'assets/images/gamification_icons/cristal.png',
                        width: 20,
                        height: 20,
                      ),
                      amount != null && amount != "null"
                          ? Text(
                              amount == "1"
                                  ? " + $amount Cristal"
                                  : " + $amount Rubis",
                              style: textStyle.copyWith(
                                fontSize: 15,
                              ),
                            )
                          : Container(),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
