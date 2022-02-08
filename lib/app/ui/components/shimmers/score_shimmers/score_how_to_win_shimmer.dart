import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScoreHowToWinShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Shimmer.fromColors(
              child: Container(
                height: 30,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
              child: Container(
                height: 80,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
              child: Container(
                height: 30,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
              child: Container(
                height: 100,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
              child: Container(
                height: 30,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
              child: Container(
                height: 70,
                width: screenWidthhSize * 0.8,
                color: Colors.white,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400]),
        ],
      ),
    ));
  }
}
