import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_iteractions_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_request_entry_members_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/interactions/request_member_item.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../../components/components.dart';

class ClanRequestEntryList extends StatefulWidget {
  @override
  _RequestEntryListState createState() => _RequestEntryListState();
}

class _RequestEntryListState extends State<ClanRequestEntryList> {
  final controller = Get.find<ClanRequestEntryMembersController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
          inAsyncCall: controller.loading.value,
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                  child: CustomAppBar(
                    appBarTxt: 'Solicitações de entrada',
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
                              'Nenhuma solicitação de entrada',
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
                            itemBuilder: (context, index) => RequestMemberItem(
                                  approveMember: () {
                                    controller.approveMember(controller
                                        .list[index].customerId
                                        .toString());
                                  },
                                  reproveMember: () {
                                    controller.reproveMemberModal(controller
                                        .list[index].customerId
                                        .toString());
                                  },
                                  member: controller.list[index],
                                  isLastItem:
                                      index == (controller.list.length) - 1,
                                )),
                  )))),
    );
  }
}
