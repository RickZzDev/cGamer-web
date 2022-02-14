import 'package:cGamer/app/data/models/clans_models/clan_ranking_model.dart';
import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/extensions/user_name_extension.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MemberRankingItem extends StatelessWidget {
  MemberRankingItem({
    required this.member,
    required this.userHasClan,
    required this.isOWnCla,
    this.position = -1,
  });

  bool userHasClan;
  bool isOWnCla;

  MemberRanking? member;
  int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 8,
              ),
              SizedBox(
                  height: 50,
                  width: 50,
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.USER_PROFILE,
                            arguments: {'customerId': member?.id});
                      },
                      child: CircleAvatar(
                          backgroundColor: secondaryColor,
                          child: member?.avatar == null
                              ? Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          width: 0.5, color: primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/images/tab_bar_icons/Perfil.svg',
                                      fit: BoxFit.contain,
                                      color: primaryColor,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ))
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          width: 0.5, color: primaryColor)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(95.0),
                                    child: CachedNetworkImage(
                                        imageUrl: member?.avatar ?? "",
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80),
                                  ))))),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text("${UserNameExtension.reduceName(member?.name)}",
                        style: textStyle.copyWith(
                            fontWeight: position == 1
                                ? FontWeight.bold
                                : position == 2
                                    ? FontWeight.bold
                                    : position == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                            fontSize: position == 1
                                ? 18
                                : position == 2
                                    ? 17
                                    : position == 3
                                        ? 16
                                        : 15)),
                  ]),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      member?.isEmbaixador ?? false
                          ? Container(
                              margin: EdgeInsets.only(right: 4),
                              child: TagEmbaixador(fontSize: 12.0))
                          : Container(),
                      member?.isPrime ?? false
                          ? Container(
                              margin: EdgeInsets.only(right: 2),
                              child: TagPrime(fontSize: 12.0))
                          : Container(),
                      Text(
                          '${member?.username != null ? '@${member?.username}' : 'sem nome de usuário'}',
                          textAlign: TextAlign.start,
                          style: textStyle.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                      onTap: () {
                        if (isOWnCla) {
                          Get.toNamed(Routes.CLAN_DETAILS,
                              preventDuplicates: false,
                              arguments: {
                                'clanId': member?.claId,
                                'userHasClan': true
                              });
                          return;
                        }

                        Get.toNamed(Routes.OTHER_CLAN,
                            preventDuplicates: false,
                            arguments: {
                              'clanId': member?.claId,
                              'userHasClan': userHasClan
                            });
                      },
                      child: Row(children: [
                        Image.network(
                          member?.claLogo ?? "",
                          height: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          member?.claName ?? "",
                          style: textStyle.copyWith(fontSize: 14),
                        )
                      ])),
                ],
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/images/gamification_icons/trophy.png',
                      height: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      member?.qtdTrophy != null ? "${member?.qtdTrophy}" : "0",
                      style: textStyle.copyWith(
                          fontWeight: position == 1
                              ? FontWeight.bold
                              : position == 2
                                  ? FontWeight.bold
                                  : position == 3
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                          fontSize: position == 1
                              ? 18
                              : position == 2
                                  ? 17
                                  : position == 3
                                      ? 16
                                      : 15),
                    )
                  ]),
                  Text('#${position}',
                      style: textStyle.copyWith(
                          fontWeight: position == 1
                              ? FontWeight.bold
                              : position == 2
                                  ? FontWeight.bold
                                  : position == 3
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                          fontSize: position == 1
                              ? 18
                              : position == 2
                                  ? 17
                                  : position == 3
                                      ? 16
                                      : 15)),
                ],
              ))
        ],
      ),
    );
  }
}
