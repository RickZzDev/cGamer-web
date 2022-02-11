import 'package:cGamer/app/controllers/score/buy_badge/buy_badge_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/buy_badges/buy_badges_list.dart';
import 'package:cGamer/app/ui/components/shimmers/score_shimmers/buy_badges_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';

class BuyBadgeView extends StatelessWidget {
  final BuyBadgeController controller = Get.find<BuyBadgeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          child: CustomAppBar(
            appBarTxt: 'Badges',
          ),
          preferredSize: Size.fromHeight(70),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidthhSize,
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomRichText(
                    textAlign: TextAlign.left,
                    normalText: 'Complete sua coleção com as',
                    customText: 'Badges',
                    normalText2: 'abaixo',
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text("Saldo: ", style: textStyle),
                      Image.asset(
                        'assets/images/gamification_icons/cristal.png',
                        height: 16,
                        width: 16,
                      ),
                      Text(
                        " ${controller.gCoins}",
                        style: textStyle.copyWith(color: primaryColor),
                      ),
                      Text(
                        " Rubis",
                        style: textStyle.copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(() => FutureBuilder(
                      future: Future.wait([
                        controller.hasCompletedBadgesRequest.value!,
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return BuyBadgesList(controller: controller);
                        } else {
                          return BuyBadgeShimer();
                        }
                      })),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GenericButton(
                          text: "Avançar",
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
        ));
  }
}
