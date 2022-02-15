import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/home_models/home_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/dot_component.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader(
      {Key? key,
      required HomeController controller,
      required HomeModel userStats})
      : _controller = controller,
        _userStats = userStats,
        super(key: key);

  final HomeController _controller;
  final HomeModel _userStats;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 8,
        child: Container(
          height: 155,
          color: primaryColor,
          child: Stack(
            children: [
              Container(
                //  height: MediaQuery.of(context).size.height * 0.18,
                height: 150,

                width: MediaQuery.of(context).size.width,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(24, 12, 12, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleAvatar(
                                          backgroundColor: secondaryColor,
                                          child: _userStats.customerAvatar ==
                                                      null ||
                                                  _userStats.customerAvatar ==
                                                      ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/tab_bar_icons/Perfil.svg',
                                                    fit: BoxFit.contain,
                                                    color: primaryColor,
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          95.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: _userStats
                                                            .customerAvatar ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 80,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(
                                        height: 120,
                                        width: 120,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                _userStats.level?.newFrameUrl ??
                                                    "",
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: 50,
                                            width: 50,
                                            cacheKey:
                                                _userStats.level?.newFrameUrl ??
                                                    "",
                                            useOldImageOnUrlChange: true,
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: GestureDetector(
                                          onTap: () => _controller.pickImage(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Olá, ${_controller.getHeaderName()}",
                                        style: textStyle.copyWith(
                                            fontSize: 16,
                                            color: secondaryColor),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(children: [
                                            _controller.isEmbaixador
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4),
                                                    child: TagEmbaixador())
                                                : Container(),
                                            _controller.isPrime
                                                ? TagPrime()
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white30,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4))),
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Text(
                                                          "MEMBRO",
                                                          style: textStyle.copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  secondaryColor),
                                                        )),
                                                  ),
                                          ])),
                                      Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Level ",
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    color: secondaryColor),
                                              ),
                                              Text(
                                                "${_controller.homeResult.value.level?.customerLevel}",
                                                style: textStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: secondaryColor),
                                              )
                                            ],
                                          )),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Obx(() => LinearPercentIndicator(
                                            width: screenWidthhSize * 0.5,
                                            animation: true,
                                            lineHeight: 16,
                                            progressColor: secondaryColor,
                                            center: Text(
                                                '${_controller.homeResult.value.level?.customerPoints.formattedPoints()} / ${_controller.homeResult.value.level?.nextLevelPoints.formattedPoints()} EXP',
                                                style: textStyle.copyWith(
                                                    fontSize: 12)),
                                            animationDuration: 1000,
                                            percent: _controller
                                                .getPercentProgressBar(),
                                            padding: EdgeInsets.only(
                                                left: 4, right: 4),
                                          )),
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
        ));
  }
}
