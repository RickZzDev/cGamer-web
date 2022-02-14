import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/extensions/user_name_extension.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MemberCardItem extends StatelessWidget {
  final bool isLastItem;
  final ClanDetailsMembers? member;
  MemberCardItem({required this.isLastItem, required this.member}) {
    this.member?.name = UserNameExtension.reduceName(member?.name);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                arguments: {'customerId': member?.customerId});
                          },
                          child: CircleAvatar(
                              backgroundColor: secondaryColor,
                              child: member?.avatarUrl == null
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
                                        borderRadius:
                                            BorderRadius.circular(95.0),
                                        child: CachedNetworkImage(
                                            imageUrl: member?.avatarUrl ?? "",
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
                        Text(
                          member?.name ?? "",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        member?.role != null
                            ? Text(
                                " (${member?.role})",
                                style: textStyle.copyWith(
                                    fontSize: 14, color: Colors.white70),
                              )
                            : Container(),
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
                            '@${member?.username}',
                            textAlign: TextAlign.start,
                            style: textStyle.copyWith(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          member?.qtdTrophy != null
                              ? "${member?.qtdTrophy}"
                              : "0",
                          style: textStyle.copyWith(fontSize: 14),
                        )
                      ])
                    ],
                  ))
            ],
          ),
        ),
        isLastItem
            ? SizedBox(
                height: 24,
              )
            : SizedBox()
      ],
    );
  }
}
