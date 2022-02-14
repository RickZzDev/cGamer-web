import 'package:cGamer/app/data/models/onboard_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:cGamer/app/ui/components/onboard_components/swiper_component.dart';
import 'package:cGamer/app/controllers/onboard/onboard_controller.dart';

class OnBoardPage extends StatelessWidget {
  final OnBoardController _onBoardController = Get.find<OnBoardController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    final SwiperController _swipperController = SwiperController();
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MultiProvider(
                providers: [
                  Provider<Function>.value(
                      value: _onBoardController.verifyIndex),
                  Provider<List<OnBoardModel>>.value(
                      value: _onBoardController.onboardList),
                ],
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: SwiperComponent(
                    swipperController: _swipperController,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                width: MediaQuery.of(context).size.width * 0.75,
                height: 48,
                child: Obx(
                  () => OutlinedButton(
                    onPressed: _onBoardController.buttonText == "Start"
                        ? () {
                            _onBoardController.setCacheValue(
                                Provider.of<GetStorage>(context,
                                    listen: false));
                            Get.toNamed(Routes.LOGIN);
                          }
                        : () => _swipperController.next(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            _onBoardController.buttonText,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Exo',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Icon(
                            _onBoardController.buttonText == "Start"
                                ? Icons.check
                                : Icons.arrow_forward_ios,
                            color: Theme.of(context).primaryColor,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
