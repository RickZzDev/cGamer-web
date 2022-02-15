import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class MembersRankingTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  '#',
                  style: textStyle.copyWith(fontSize: 16, color: primaryColor),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Membros',
                  style: textStyle.copyWith(fontSize: 16, color: primaryColor),
                )
              ]),
              Image.asset(
                'assets/images/gamification_icons/trophy.png',
                height: 20,
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 1,
            color: primaryColor,
          )
        ]));
  }
}
