import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/title_divider.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class MembersCloud extends StatelessWidget {
  MembersCloud({Key? key, required this.members}) : super(key: key);

  final List<ClanDetailsMembers> members;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Membros caçando agora..",
          textAlign: TextAlign.start,
          style: textStyle,
        ),
        Divider(
          color: Colors.transparent,
        ),
        members.length == 0
            ? Container(
                height: 100,
                child: Text(
                  "Nenhum membro ainda iniciou a caçada, seja o primeiro!",
                  textAlign: TextAlign.start,
                  style: textStyle.copyWith(fontSize: 14),
                ))
            : Container(
                height: 180,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: MemberItem(
                            imageUrl: members[index].avatarUrl ?? null,
                            userName: members[index].username!),
                      );
                    }),
              ),
      ],
    );
  }
}
