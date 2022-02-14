import 'package:cGamer/app/controllers/profile/my_progress/my_progress_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/levels_components/levels_list_component.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/verify_future_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProgressPage extends StatefulWidget {
  @override
  _MyProgressPageState createState() => _MyProgressPageState();
}

class _MyProgressPageState extends State<MyProgressPage> {
  final MyProgressController _controller = Get.find<MyProgressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            appBarTxt: "Levels",
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/gamification_icons/background_levels.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: _controller.scrollController,
                  child: Obx(() => FutureBuilder(
                        future: Future.wait([
                          _controller.hasCompletedLevelsRequest.value,
                        ]),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshots) {
                          if (FutureUtils.verifyFutureState(
                                  snapshots, _controller.allComplete) ||
                              _controller.allComplete.value)
                            return LevelsListComponent(
                              controller: _controller,
                            );
                          else
                            return MyProgressShimer();
                        },
                      )),
                ))
          ],
        ));
  }
}
