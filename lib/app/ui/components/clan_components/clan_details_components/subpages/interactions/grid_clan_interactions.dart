import 'package:cGamer/app/controllers/clan_controllers/clan_iteractions_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../../../components.dart';

class GridClanInteractions extends StatelessWidget {
  final ClanIteractionsController controller;

  GridClanInteractions({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: controller.iterations.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GridClanItem(
        model: new GridClanItemModel(controller.iterations[index].name ?? "",
            getAction(controller.iterations[index].name ?? "")),
      ),
    );
  }

  Function() getAction(String title) {
    switch (title) {
      case "recruitMember":
        return () {};
      case "requestEntry":
        return () {
          Get.toNamed(Routes.CLAN_REQUEST_ENTRY,
              arguments: {"clanId": controller.clanId});
        };

      case "manageMembers":
        return () {
          Get.toNamed(Routes.CLAN_MANAGE_MEMBERS,
              arguments: {"clanId": controller.clanId});
        };

      case "leftClan":
        return () {
          controller.leftClan();
        };
      default:
        return () {};
    }
  }
}
