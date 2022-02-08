import 'package:cGamer/app/controllers/clan_controllers/clan_controller.dart';
import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/search_friend_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/my_clan/create_clan/create_clan_component.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/play_together_components/connections_components/subpages/gamers_list.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriends extends StatelessWidget {
  final _controller = Get.find<SearchFriendController>();

  @override
  Widget build(BuildContext context) {
    ScreenUtils.changeSystemColors(statusBarColor: secondaryColor);

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
          child: CustomAppBar(
            appBarTxt: 'Procurar amigos',
          ),
          preferredSize: Size.fromHeight(60)),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            CustomTextField(
              sufixIcon: Icon(
                Icons.search,
                color: primaryColor,
                size: 24,
              ),
              labelText: 'Procurar um gamer',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  height: 0,
                  fontFamily: 'Exo'),
              autoFocus: false,
              darkMode: false,
              fontSize: 18,
              onChange: (v) {
                _controller.verify(v);
                _controller.syncQuery(v);
                _controller.getGamersList();
              },
              controller: _controller.textEditingController,
            ),
            SizedBox(
              height: 24,
            ),
            Obx(() => _controller.showCreateClan.value
                ? Column(children: [
                    CustomRichText(
                      customFirst: false,
                      textAlign: TextAlign.center,
                      customText: "username",
                      normalText: "Procure gamers pelo",
                      normalText2: "ou",
                      customText2: "nome",
                      normalText3: "para adicionar a sua lista de amigos!",
                    )
                  ])
                : Expanded(
                    child: _controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ),
                          )
                        : GamersList(_controller.gamersList, _controller))),
          ],
        ),
      ),
    );
  }
}
