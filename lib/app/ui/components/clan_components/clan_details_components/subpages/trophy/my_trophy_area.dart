import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MyTrophyArea extends StatelessWidget {
  final String? title;
  final String? qtdTrophy;

  const MyTrophyArea({Key? key, this.qtdTrophy, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  style: textStyle.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ]),
          Row(children: [
            Image.asset(
              'assets/images/gamification_icons/trophy.png',
              height: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              qtdTrophy ?? "",
              style: textStyle.copyWith(fontSize: 14),
            )
          ])
        ],
      ),
    );
  }
}
