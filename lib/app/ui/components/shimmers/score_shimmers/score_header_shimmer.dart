import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScoreHeaderShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            height: 135,
            //color: Colors.yellow,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Shimmer.fromColors(
                          child: ClipOval(
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.white,
                            ),
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: 50,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style: textStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 30,
                            width: screenWidthhSize * 0.6,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: screenWidthhSize * 0.6,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: screenWidthhSize * 0.6,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: screenWidthhSize * 0.6,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
