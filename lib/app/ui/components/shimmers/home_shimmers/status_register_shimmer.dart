import 'package:cGamer/app/ui/components/shimmers/home_shimmers/benefits_card_shimmer.dart';
import 'package:cGamer/app/ui/components/shimmers/home_shimmers/missions_card_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StatusRegisterShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Theme.of(context).accentColor,
                highlightColor: Colors.blueGrey[400],
                child: MissionsCardShimmer(),
              ),
              Shimmer.fromColors(
                baseColor: Theme.of(context).accentColor,
                highlightColor: Colors.blueGrey[400],
                child: MissionsCardShimmer(),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).accentColor,
            highlightColor: Colors.blueGrey[400],
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 10,
              width: 160,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BenefitsCardShimmer(),
              BenefitsCardShimmer(),
              BenefitsCardShimmer(),
              BenefitsCardShimmer(),
            ],
          )
        ],
      ),
    );
  }
}
