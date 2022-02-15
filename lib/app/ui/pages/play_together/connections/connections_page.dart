import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/connections_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ConnectionsPage extends StatefulWidget {
  ConnectionsPage({Key? key}) : super(key: key);

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  final ConnectionController controller = Get.find<ConnectionController>();

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarColor(
        controller.fromHome ? primaryColor : secondaryColor);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
            backgroundColor: secondaryColor,
            appBar: PreferredSize(
              child: CustomAppBar(
                appBarTxt: "Conexões",
              ),
              preferredSize: Size.fromHeight(60),
            ),
            body: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      bottom: TabBar(indicatorColor: primaryColor, tabs: [
                        Tab(
                          child: Text(
                            'Conversas',
                            style: textStyle,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Amigos',
                            style: textStyle,
                          ),
                        )
                      ]),
                    )),
                body: Container(
                    color: secondaryColor,
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ConversationSubpage(
                            controller: controller,
                          ),
                          FriendsSubPage(controller: controller)
                        ])),
              ),
            ))));
  }
}
