import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid_gamer.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid_services.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/ui/pages/pro/pro_view.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class LoLSubPageGrid extends StatelessWidget {
  LoLSubPageGrid({required this.controller});
  final PlayToWinController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 4),
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12)),
      ),
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              elevation: 0,
              backgroundColor: Colors.white.withAlpha(30),
              bottom: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorColor: Colors.green,
                tabs: [
                  Tab(
                    text: "Jogos do dia",
                  ),
                ],
                labelColor: primaryColor,
                unselectedLabelColor: Colors.grey,
                indicator: null,
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: TabBarView(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio:
                                ((screenWidthhSize - 50) / 80) / 5),
                        itemBuilder: (context, index) {
                          int i = index + 1;
                          return GestureDetector(
                              onTap: () {
                                if (!controller.isPrime && i > 5) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProView(),
                                        fullscreenDialog: true),
                                  );
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                      child: Center(
                                          child: Stack(children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40))),
                                        child: i <=
                                                    (controller
                                                            .gameInfoModel
                                                            ?.details
                                                            ?.qtdGamesDaily ??
                                                        0) ||
                                                (controller.gameInfoModel?.details?.rescueToday ??
                                                    false)
                                            ? Icon(Icons.check,
                                                color: primaryColor)
                                            : Center(
                                                child: !controller.isPrime && i > 5
                                                    ? Icon(Icons.lock_outline_rounded,
                                                        color: primaryColor)
                                                    : Text('$i', style: textStyle.copyWith()))),
                                    i > 5 && !controller.isPrime
                                        ? TagPrime(
                                            transform:
                                                Matrix4.translationValues(
                                                    20.0, -8.0, 0.0),
                                            fontSize: 10.0,
                                          )
                                        : Container(
                                            height: 4,
                                            width: 20,
                                            transform:
                                                Matrix4.translationValues(
                                                    20.0, -8.0, 0.0),
                                          ),
                                  ])))
                                ],
                              ));
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
