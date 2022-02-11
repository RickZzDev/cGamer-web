import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartLevelCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 1.2),
            child: SvgPicture.asset(
              'assets/images/gamification_icons/background_start_levels.svg',
              width: 150,
              color: primaryColor,
            )),
        Container(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Início",
                style: textStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "0 EXP",
                style: textStyle.copyWith(
                    fontSize: 18,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
