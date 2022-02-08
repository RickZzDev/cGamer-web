import 'package:cGamer/app/controllers/cash_actions_controllers/cash_in_types/cash_in_types.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CahsInOption extends StatelessWidget {
  final CashInTypeController controller;
  final String imgPath;
  final IconData? icon;
  final String title;
  final String subtitle;
  final Function onTap;
  final bool animateIcon;
  const CahsInOption(
      {Key? key,
      required this.controller,
      required this.imgPath,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.subtitle,
      this.animateIcon = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            child: SvgPicture.asset(
              'assets/images/deposit_way_icons/$imgPath.svg',
              color: themes.primaryColor,
              height: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            width: themes.screenWidthhSize - 110,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: themes.textStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: themes.textStyle.copyWith(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                !animateIcon
                    ? Icon(
                        icon,
                        color: Colors.white70,
                      )
                    : RotationTransition(
                        turns: controller.animation!,
                        child: Icon(
                          icon,
                          color: Colors.white70,
                          size: 32,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
