import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ClanMembers extends StatelessWidget {
  final List<ClanDetailsMembers>? list;

  ClanMembers(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Container(
        padding: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.transparent,
                ),
            itemCount: list?.length ?? 0,
            itemBuilder: (context, index) => MemberCardItem(
                  member: list?[index],
                  isLastItem: index == (list?.length ?? 0) - 1,
                )),
      ),
    );
  }
}
