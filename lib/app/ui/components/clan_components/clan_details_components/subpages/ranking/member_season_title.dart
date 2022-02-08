import 'package:cGamer/app/controllers/clan_controllers/clan_ranking_controller.dart';
import 'package:cGamer/app/data/models/clans_models/clan_ranking_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class MemberSeasonTitle extends StatelessWidget {
  MemberSeasonTitle({required this.controller});

  ClanRankingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: 195,
        color: Colors.white.withOpacity(0.075),
        child: Column(children: [
          Text(
            '${controller.rankingModelResult.value.season?.name}',
            style: textStyle.copyWith(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            'Encerra em',
            style: textStyle.copyWith(fontSize: 14, color: Colors.white),
          ),
          CountdownTimer(
            endTime: controller.getTimeLeft(
                controller.membersModelResult.value.season?.dateFinish),
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return Container(
                    child: Text('Temporada finalizada',
                        style: textStyle.copyWith(
                            fontSize: 22,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)));
              }
              return Container(
                  child: Text(
                      time.sec! < 10
                          ? '${time.days ?? 0}d ${time.hours ?? 0}:${time.min ?? 0}:0${time.sec}'
                          : '${time.days ?? 0}d ${time.hours ?? 0}:${time.min ?? 0}:${time.sec}',
                      style: textStyle.copyWith(
                          fontSize: 22,
                          color: primaryColor,
                          fontWeight: FontWeight.bold)));
            },
          ),

          SizedBox(height: 4),
          Text(
            'Premiação',
            style: textStyle.copyWith(fontSize: 16, color: Colors.white),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' 1.º ${controller.membersModelResult.value.season?.prize?[0]} ',
                style: textStyle.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/gamification_icons/cristal.png',
                width: 20,
                height: 20,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' 2.º ${controller.membersModelResult.value.season?.prize?[1]} ',
                style: textStyle.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/gamification_icons/cristal.png',
                width: 20,
                height: 20,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' 3.º ${controller.membersModelResult.value.season?.prize?[2]} ',
                style: textStyle.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/gamification_icons/cristal.png',
                width: 20,
                height: 20,
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Premiação individual para quem fizer mais troféus!',
            style: textStyle.copyWith(fontSize: 12, color: Colors.white),
          ),

          // Image.asset(
          //   'assets/images/gamification_icons/trophy.png',
          //   height: 20,
          //   width: 20,
          // )

          SizedBox(
            height: 8,
          ),
        ]));
  }
}
