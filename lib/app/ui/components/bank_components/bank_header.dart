import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/dot_component.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BankHeader extends StatelessWidget {
  BankHeader(
      {Key? key,
      required BankController controller,
      required HomeModel userStats})
      : _controller = controller,
        _userStats = userStats,
        super(key: key);

  final BankController _controller;
  final HomeModel _userStats;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: secondaryColor,
      child: Stack(
        children: [
          Container(
            //  height: MediaQuery.of(context).size.height * 0.18,
            height: 150,

            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  24,
                ),
                bottomRight: Radius.circular(
                  24,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá, ${_controller.getHeaderName()}",
                                    style: textStyle.copyWith(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Text(
                                        "Saldo",
                                        style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      )),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(() {
                                          return AnimatedSwitcher(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              child: _controller.moneyVisibility
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      height: 36,
                                                      child: Text(
                                                        "${_controller.balanceModel.balanceAvailable?.available}",
                                                        style:
                                                            textStyle.copyWith(
                                                                fontSize: 22,
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFE1E1E1)),
                                                        key: ValueKey(1),
                                                      ))
                                                  : Container(
                                                      height: 36,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "R\$ ",
                                                            style: textStyle.copyWith(
                                                                fontSize: 22,
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFE1E1E1)),
                                                            key: ValueKey(1),
                                                          ),
                                                          DotsComponent()
                                                        ],
                                                      )));
                                        }),
                                        Obx(
                                          () => GestureDetector(
                                            onTap: () => _controller
                                                .changeVisibility(!_controller
                                                    .moneyVisibility),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 12, top: 3),
                                              child: Icon(
                                                _controller.moneyVisibility
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                                size: 24,
                                                color: Color(0xFFE1E1E1),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                ],
                              )
                            ],
                          ),
                          /*  Container(
                          height: 50,
                          width: 50,
                          child: Icon(Icons.notifications, color: secondaryColor),
                        ),*/
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ActionsCardComponent(
          //     status: _controller.statusRegisterResult.value.statusBanlky,
          //   ),
          // )
        ],
      ),
    );
  }
}
