import 'package:cGamer/app/ui/components/home_components/last_moviments_component.dart';
import 'package:cGamer/app/ui/components/shimmers/home_shimmers/action_card_shimmer.dart';
import 'package:cGamer/app/ui/components/shimmers/home_shimmers/banner_shimmer.dart';
import 'package:cGamer/app/ui/components/shimmers/home_shimmers/mission_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SecondBodyShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ActionCardShimer(), ActionCardShimer()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ActionCardShimer(), ActionCardShimer()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400],
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) =>
                    LastMovimentsComponentShimmer(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
            child: Shimmer.fromColors(
              child: Container(
                color: Colors.white,
                height: 15,
                width: 80,
              ),
              baseColor: Theme.of(context).accentColor,
              highlightColor: Colors.blueGrey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MissionCardShimmer(),
                MissionCardShimmer(),
                MissionCardShimmer(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BannerShimmer(),
          )
        ],
      ),
    );
  }
}
