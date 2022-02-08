import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shimmer/shimmer.dart';

class CashbackListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) => _shimmerItem(context),
          separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
          itemCount: 3),
    );
  }

  Widget _shimmerItem(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
      ),
      baseColor: Theme.of(context).accentColor,
      highlightColor: Colors.blueGrey[400],
    );
  }
}
