import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class LastMovimentsComponent extends StatelessWidget {
  final String? title;
  final String? toName;
  final String? date;
  final String? amount;
  final String? imgSrc;
  final bool isLast;
  final Function()? onClick;
  LastMovimentsComponent({
    Key? key,
    required this.imgSrc,
    required this.title,
    this.toName,
    required this.date,
    required this.amount,
    this.onClick,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onClick,
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
                      child: SvgPicture.network(
                        imgSrc ?? "",
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
                      toName != null
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    toName!,
                                    style: textStyle.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          amount != null && amount != "null"
                                              ? 14
                                              : 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      amount != null && amount != "null"
                          ? Text(
                              amount ?? "",
                              style: textStyle.copyWith(
                                fontSize: 15,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LastMovimentsComponentShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.blueGrey[200],
      child: Padding(
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
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 70,
                              color: Colors.white,
                            ),
                            Container(
                              height: 15,
                              width: 80,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 15,
                        width: 90,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 15,
                        width: 90,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
