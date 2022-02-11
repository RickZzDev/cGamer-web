import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ClanDetailsShimmer extends StatelessWidget {
  const ClanDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 80,
              width: screenWidthhSize,
              child: Center(
                child: SizedBox(
                    width: 80,
                    height: 50,
                    child: Shimmer.fromColors(
                      baseColor: Theme.of(context).accentColor,
                      highlightColor: Colors.blueGrey[400],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ),
            Container(
              width: screenWidthhSize,
              height: 2,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
