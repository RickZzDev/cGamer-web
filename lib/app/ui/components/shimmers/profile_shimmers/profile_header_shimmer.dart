import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeaderShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                child: Container(
                  height: 80,
                  width: 80,
                  color: Colors.white,
                ),
                baseColor: Theme.of(context).accentColor,
                highlightColor: Colors.blueGrey[400],
              ),
              SizedBox(
                width: 24,
              ),
              Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.55,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Shimmer.fromColors(
                          child: Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.55,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        )),
                    Row(
                      children: [
                        Shimmer.fromColors(
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          baseColor: Theme.of(context).accentColor,
                          highlightColor: Colors.blueGrey[400],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                child: Container(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  color: Colors.white,
                                ),
                                baseColor: Theme.of(context).accentColor,
                                highlightColor: Colors.blueGrey[400],
                              ),
                              Container(
                                // color: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Shimmer.fromColors(
                                      child: Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        color: Colors.white,
                                      ),
                                      baseColor: Theme.of(context).accentColor,
                                      highlightColor: Colors.blueGrey[400],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
