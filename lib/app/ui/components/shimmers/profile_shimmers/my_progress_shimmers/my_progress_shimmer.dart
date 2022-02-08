import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyProgressShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/gamification_icons/background_levels.png',
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          height: 200,
                          width: 300,
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
                          height: 200,
                          width: 300,
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
                          height: 200,
                          width: 300,
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
                          height: 200,
                          width: 300,
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
                          height: 200,
                          width: 300,
                          color: Colors.white,
                        ),
                        baseColor: Theme.of(context).accentColor,
                        highlightColor: Colors.blueGrey[400],
                      ),
                    ],
                  )),
            ],
          ))))
    ]);
  }
}
