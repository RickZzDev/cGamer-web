import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactRowTransferShimmer extends StatelessWidget {
  const ContactRowTransferShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: utils.secondaryColor,
      highlightColor: Colors.blueGrey[400],
      child: Container(
        height: utils.screenHeigthSize * 0.35,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 8,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: utils.primaryColor,
                  child: Text(
                    "",
                    style: utils.textStyle,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  width: utils.screenWidthhSize * 0.75,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: utils.textStyle,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
