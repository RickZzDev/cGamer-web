import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MissionCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).accentColor,
      highlightColor: Colors.blueGrey[400],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        width: MediaQuery.of(context).size.width * 0.3,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              // spreadRadius: 0,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
