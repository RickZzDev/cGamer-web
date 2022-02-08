import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VirtualCardTransactionComponent extends StatelessWidget {
  final String? title;
  final String? date;
  final String? value;
  final bool isLast;
  VirtualCardTransactionComponent({
    Key? key,
    required this.title,
    required this.date,
    required this.value,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: primaryColor,
                  width: 0.5,
                  height: 15,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  date ?? "",
                  style: textStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  color: isLast ? Colors.transparent : primaryColor,
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
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: value != null ? 0 : 8,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    title ?? "",
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  value != null
                      ? Text(
                          value ?? "",
                          style: textStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LastMovimentsComponentShimmer extends StatelessWidget {
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
                    color: Colors.white,
                    // child: Icon(
                    //   Icons.cached_sharp,
                    //   color: Colors.white,
                    // ),
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
    );
  }
}
