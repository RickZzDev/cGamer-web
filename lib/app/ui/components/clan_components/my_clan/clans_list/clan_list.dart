import 'package:cGamer/app/controllers/clan_controllers/clan_controller.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/keyboard_is_open.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components.dart';

class ClansList extends StatelessWidget {
  final List<ClanModel> list;
  final ClanController controller;

  ClansList(this.list, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.transparent,
              ),
          itemCount: controller.clansLists.value.length,
          itemBuilder: (context, index) {
            return ClanListItem(list[index], onTap: (id) {
              FocusScope.of(context).unfocus();
              Get.toNamed(Routes.CLAN_DETAILS,
                  preventDuplicates: false, arguments: {'clanId': id});
            });
          }),
    );
  }
}
