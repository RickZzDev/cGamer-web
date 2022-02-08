import 'package:cGamer/app/controllers/wallet_controllers/wallet_controller.dart';
import 'package:cGamer/app/ui/components/wallet_components/card_component.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletHeader extends StatelessWidget {
  const WalletHeader({Key? key, required WalletController controller})
      : _controller = controller,
        super(key: key);

  final WalletController _controller;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      elevation: 8,
      child: Container(
          width: screenWidthhSize,
          height: 224,
          // margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Container(
                padding: EdgeInsets.only(top: 32, bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: 224,
                child: CarouselSlider.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Obx(() => CardComponent(
                              isBlocked:
                                  _controller.virtualCardModel.value != null &&
                                      _controller.virtualCardModel.value
                                              .cardStatus ==
                                          "TemporarilyUserLocked",
                              aliasCard: _controller.virtualCardModel.value !=
                                          null &&
                                      _controller.virtualCardModel.value
                                              .cardAlias !=
                                          null
                                  ? _controller.virtualCardModel.value.cardAlias
                                  : "",
                            ))
                      ]);
                    },
                    options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            _controller.currentIndex.value = index,
                        height: 176,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.75,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInBack,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal))

                //  ListView.separated(
                //   separatorBuilder: (BuildContext context, int index) {
                //     return SizedBox(
                //       width: 24,
                //     );
                //   },
                //   scrollDirection: Axis.horizontal,
                //   itemCount: 2,
                //   shrinkWrap: true,
                //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                //   itemBuilder: (context, index) {
                //     return CardComponent(
                //       status: "Activated",
                //     );
                //   },
                // ),
                ),
          )),
    );
  }
}
