import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactsShimmer extends StatelessWidget {
  const ContactsShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
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
    );
  }
}
