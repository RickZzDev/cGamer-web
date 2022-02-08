import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BodyCardShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          Shimmer.fromColors(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
          ),
          SizedBox(
            height: 24,
          ),
          Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              height: 60,
              width: MediaQuery.of(context).size.width - 48,
            ),
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
          ),
          SizedBox(
            height: 16,
          ),
          Shimmer.fromColors(
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
          ),
        ]));
  }
}
