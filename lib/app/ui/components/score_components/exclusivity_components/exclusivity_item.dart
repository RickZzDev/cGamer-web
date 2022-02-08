import 'package:cGamer/app/utils/generic_utils/hero_util.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ExclusivityItem extends StatelessWidget {
  final bool hasBorder;
  final String imageAsset;
  final String title;
  final String description;
  final String message;
  final Function(String) onTap;
  String? _heroTag;

  ExclusivityItem(
      {this.hasBorder = false,
      required this.onTap,
      required this.imageAsset,
      required this.title,
      required this.description,
      required this.message}) {
    _heroTag = HeroUtil().getUniqueId();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(_heroTag ?? "");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 80,
        decoration: BoxDecoration(
            border: Border(
                bottom: hasBorder
                    ? BorderSide(color: Colors.white)
                    : BorderSide.none)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: _heroTag ?? "",
              child: Image.asset(
                imageAsset,
                height: 65,
                width: 65,
              ),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: textStyle,
                ),
                Text(
                  description,
                  style: textStyle.copyWith(fontSize: 14),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/gamification_icons/cristal.png',
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      message,
                      style:
                          textStyle.copyWith(color: primaryColor, fontSize: 16),
                    )
                  ],
                )
              ],
            )),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
