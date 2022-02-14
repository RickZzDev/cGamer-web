import 'package:cGamer/app/controllers/clan_controllers/clan_iteractions_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/interactions/grid_clan_interactions.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ClanInteractions extends StatelessWidget {
  final controller = Get.find<ClanIteractionsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: PreferredSize(
                child: CustomAppBar(
                  appBarTxt: 'Outras opções',
                ),
                preferredSize: Size.fromHeight(60)),
            body: Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              color: secondaryColor,
              child: GridClanInteractions(controller: controller),
            ))));
  }
}
