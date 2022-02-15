import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_request_entry_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cGamer/app/utils/extensions/user_name_extension.dart';

class RequestMemberItem extends StatelessWidget {
  final bool isLastItem;
  final Function() approveMember;
  final Function() reproveMember;
  final ClanRequestMembers? member;
  RequestMemberItem(
      {required this.isLastItem,
      required this.member,
      required this.approveMember,
      required this.reproveMember}){
        this.member?.name =  UserNameExtension.reduceName(member?.name);

      }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                        height: 50,
                        width: 50,
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
                                      borderRadius: BorderRadius.circular(95.0),
                                      child: CachedNetworkImage(
                                          imageUrl: member?.avatarUrl ?? "",
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80),
                                    )))),
                    SizedBox(
                      width: 12,
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
                        ]),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '@${member?.username}',
                          textAlign: TextAlign.start,
                          style: textStyle.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12),
                        )
                      ],
                    )
                  ]),
              Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GenericButton(
                          text: 'Aceitar',
                          onPressedFunction: approveMember,
                          height: 24),
                      SizedBox(
                        height: 8,
                      ),
                      GenericButton(
                          text: 'Recusar',
                          height: 24,
                          color: Colors.white70,
                          onPressedFunction: reproveMember)
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
