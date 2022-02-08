import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeaderShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                  ),
                ),
                baseColor: Theme.of(context).accentColor,
                highlightColor: Colors.blueGrey[400],
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 15,
                      width: 150,
                      color: Colors.white,
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.blueGrey[400],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 15,
                      width: 80,
                      color: Colors.white,
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.blueGrey[400],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 15,
                      width: 150,
                      color: Colors.white,
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.blueGrey[400],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Shimmer.fromColors(
                    child: Container(
                      height: 15,
                      width: 150,
                      color: Colors.white,
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.blueGrey[400],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
