import 'package:cGamer/app/controllers/clan_controllers/clan_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/my_clan/create_clan/create_clan_component.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Clan extends StatelessWidget {
  final _controller = Get.find<ClanController>();

  @override
  Widget build(BuildContext context) {
    ScreenUtils.changeSystemColors(statusBarColor: secondaryColor);

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
          child: CustomAppBar(
            appBarTxt: 'Meu clã',
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
              labelText: 'Procurar um clã',
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
                _controller.syncClanName(v);
                _controller.getClansList();
              },
              controller: _controller.textEditingController,
            ),
            SizedBox(
              height: 24,
            ),
            Obx(() => _controller.showCreateClan.value
                ? CreateClanComponent()
                : Expanded(
                    child: _controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                            ),
                          )
                        : ClansList(
                            _controller.clansLists.value, _controller))),
          ],
        ),
      ),
    );
  }
}
