import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_iteractions_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_manage_members_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_request_entry_members_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/interactions/manage_member_item.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/interactions/request_member_item.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../../components/components.dart';

class ManageMembersList extends StatefulWidget {
  @override
  _ManageMembersListState createState() => _ManageMembersListState();
}

class _ManageMembersListState extends State<ManageMembersList> {
  final controller = Get.find<ClanManagerMembersController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
          inAsyncCall: controller.loading.value,
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                  child: CustomAppBar(
                    appBarTxt: 'Gerenciar membros',
                  ),
                  preferredSize: Size.fromHeight(60)),
              body: Container(
                  color: secondaryColor,
                  child: Container(
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: controller.list.length == 0
                        ? Container(
                            width: screenWidthhSize,
                            child: Text(
                              'Nenhum membro foi encontrado',
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.transparent,
                                ),
                            itemCount: controller.list.length,
                            itemBuilder: (context, index) => ManageMemberItem(
                                  removeMember: () {
                                    controller.deleteMemberModal(controller
                                        .list[index].customerId
                                        .toString());
                                  },
                                  promoveMember: () {
                                    controller.promoveModal(
                                        controller.list[index].customerId
                                            .toString(),
                                        "Líder");
                                  },
                                  member: controller.list[index],
                                  isLastItem:
                                      index == (controller.list.length) - 1,
                                )),
                  )))),
    );
  }
}
