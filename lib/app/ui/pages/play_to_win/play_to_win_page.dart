import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/pro_banner.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/screen_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';

class PlayToWinPage extends StatefulWidget {
  @override
  _PlayToWinPageState createState() => _PlayToWinPageState();
}

class _PlayToWinPageState extends State<PlayToWinPage> {
  final PlayToWinController _controller = Get.find<PlayToWinController>();

  void initState() {
    ScreenUtils.changeSystemColors(statusBarColor: secondaryColor);
    super.initState();
  }

  void dispose() {
    ScreenUtils.changeSystemColors(statusBarColor: primaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                child: CustomAppBar(
                  appBarTxt: 'Jogue e ganhe',
                ),
                preferredSize: Size.fromHeight(60),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // PlayToWinCarousel(
                      //   controller: this._controller,
                      // ),

                      // Container(
                      //   height: screenHeigthSize,
                      //   width: screenWidthhSize,
                      //   child: PageView(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     controller: _controller.pageController,
                      //     children: [
                      LolSubPage(controller: _controller),
                      //ValorantSubPage()
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 45, vertical: Platform.isIOS ? 40 : 0),
                child: Obx(() => _controller.hasDetailsLoaded.value
                    ? GenericButton(
                        enabled: _controller.gameInfoModel?.details == null ||
                            !(_controller.gameInfoModel?.details?.rescueToday ??
                                false),
                        text: _controller
                            .getButtonTitle(_controller.currentGame.value),
                        txtColor: Colors.white,
                        onPressedFunction: () => _controller
                            .buttonOnTap(_controller.currentGame.value))
                    : Container()),
              )),
        ));
  }
}
