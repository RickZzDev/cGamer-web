import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ActionCardShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).accentColor,
      highlightColor: Colors.blueGrey[400],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 70,
        padding: EdgeInsets.only(top: 8, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
