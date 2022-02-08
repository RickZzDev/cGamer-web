import 'package:cGamer/app/controllers/score/my_badges/my_badge_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/my_badges/my_badges_list.dart';
import 'package:cGamer/app/ui/components/shimmers/score_shimmers/buy_badges_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyBadgeView extends StatelessWidget {
  final MyBadgeController controller = Get.find<MyBadgeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: 'Meus badges',
            ),
            preferredSize: Size.fromHeight(70)),
        body: Obx(() => ModalProgressHUD(
            inAsyncCall: controller.loading.value,
            child: SingleChildScrollView(
              child: Container(
                width: screenWidthhSize,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => FutureBuilder(
                          future: Future.wait([
                            controller.hasCompletedBadgesRequest.value!
                          ]),
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return MyBadgesList(controller: controller);
                            } else {
                              return BuyBadgeShimer();
                            }
                          })),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GenericButton(
                              text: "Salvar",
                              haveToReturnContext: false,
                              onPressedFunction: () {
                                controller.goNextPage();
                              },
                              txtColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }
}
