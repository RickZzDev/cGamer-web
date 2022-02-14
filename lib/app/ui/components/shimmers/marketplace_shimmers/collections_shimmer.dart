import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CollectionsShimmer extends StatelessWidget {
  const CollectionsShimmer({
    required String titleComponent,
    Key? key,
  })  : this.title = titleComponent,
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: textStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Shimmer.fromColors(
                baseColor: secondaryColor,
                highlightColor: Colors.blueGrey[400],
                child: Container(
                  height: 80,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(
                        "BG",
                        style: textStyle,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    itemCount: 8,
                  ),
                ),
              )
            ],
          ),
        )
        // child:
        );
  }
}
