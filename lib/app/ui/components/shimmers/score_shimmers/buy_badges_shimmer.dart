import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuyBadgeShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            Column(
              children: [
                Shimmer.fromColors(
                  child: Container(
                    height: 120,
                    width: screenWidthhSize,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
                SizedBox(
                  height: 24,
                ),
                Shimmer.fromColors(
                  child: Container(
                    height: 120,
                    width: screenWidthhSize,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
                SizedBox(
                  height: 24,
                ),
                Shimmer.fromColors(
                  child: Container(
                    height: 120,
                    width: screenWidthhSize,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
                SizedBox(
                  height: 24,
                ),
                Shimmer.fromColors(
                  child: Container(
                    height: 120,
                    width: screenWidthhSize,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
                SizedBox(
                  height: 24,
                ),
                Shimmer.fromColors(
                  child: Container(
                    height: 120,
                    width: screenWidthhSize,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
              ],
            ),
          ],
        ))));
  }
}
