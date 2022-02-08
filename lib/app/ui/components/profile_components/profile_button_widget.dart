import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  final String imgSrc;
  final String text;
  final Function() onTap;
  final bool? hasBorder;
  const ProfileButton({
    Key? key,
    this.hasBorder,
    required this.imgSrc,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: hasBorder != null
                ? BorderSide.none
                : BorderSide(color: primaryColor, width: 0.5),
          ),
        ),
        padding: EdgeInsets.only(left: screenWidthhSize * 0.01),
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(imgSrc,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  text,
                  style: textStyle.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
