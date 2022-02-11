import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/clan_controllers/clan_details_other_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/chat/clan_chat.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/clan_dont_permission_access.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/trophy/earn_trophy.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shimmer/shimmer.dart';

class ClanDetailsOtherPage extends StatefulWidget {
  @override
  _ClanDetailsOtherPageState createState() => _ClanDetailsOtherPageState();
}

class _ClanDetailsOtherPageState extends State<ClanDetailsOtherPage> {
  final controller = Get.find<ClanDetailsOtherController>();

  final HomeController _homeController = Get.put(
    HomeController(
      repository:
          HomeRepository(apiClient: HomeApiClient(httpClient: Requester())),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    final double appBarSize = 60;

    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Container(
            color: secondaryColor,
            child: Obx(() => controller.modelHasLoaded.value
                ? DefaultTabController(
                    length: controller.tabs?.length ?? 0,
                    child: Scaffold(
                        backgroundColor: secondaryColor,
                        appBar: PreferredSize(
                            child: isEditing()
                                ? AppBarEditView(
                                    controller.appBarTextController!,
                                    controller)
                                : CustomAppBar(
                                    appBarTxt:
                                        controller.detailsModel?.name ?? "",
                                    actions: controller.detailsModel?.isAdmin ??
                                            false
                                        ? [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 24,
                                                  color: primaryColor,
                                                ),
                                                onPressed: () {
                                                  controller.isEditing.value =
                                                      !controller
                                                          .isEditing.value;
                                                })
                                          ]
                                        : null,
                                  ),
                            preferredSize: Size.fromHeight(appBarSize)),
                        body: Container(
                          height: screenHeigthSize - appBarSize,
                          child: Column(
                            children: [
                              ClanInformations(controller),
                              Expanded(
                                child: Scaffold(
                                    appBar: PreferredSize(
                                      preferredSize: Size.fromHeight(50),
                                      child: AppBar(
                                        elevation: 4,
                                        bottom: TabBar(
                                          indicatorColor: primaryColor,
                                          indicatorWeight: 4,
                                          tabs: controller
                                                      .detailsModel?.isMember ??
                                                  false
                                              ? controller.tabs!
                                              : controller.tabsNoMember!,
                                        ),
                                      ),
                                    ),
                                    body: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          ClanMembers(
                                              controller.detailsModel?.members),
                                          controller.detailsModel?.isMember ??
                                                  false
                                              ? ClanEarnTrophy(
                                                  controller, _homeController)
                                              : ClanDontPermissionAccess(),
                                          controller.detailsModel?.isMember ??
                                                  false
                                              ? Obx(() => controller.roomOfClan
                                                          .value?.id ==
                                                      ""
                                                  ? Container(
                                                      color: secondaryColor,
                                                    )
                                                  : ClanChatPage(
                                                      room: controller
                                                          .roomOfClan.value!))
                                              : ClanDontPermissionAccess(),
                                        ])),
                              )
                            ],
                          ),
                        )))
                : Container()))));
  }

  bool isEditing() {
    if (controller.isEditing.value) {
      return true;
    }
    return false;
  }
}
