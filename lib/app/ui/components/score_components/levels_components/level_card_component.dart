import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class LevelsCard extends StatelessWidget {
  LevelsCard({
    required this.level,
    this.multiplyPointsText = "",
    this.unlocked = false,
    this.points = 0,
    this.imagePath = "",
  });

  final String level;
  final String multiplyPointsText;
  final String imagePath;
  final bool unlocked;
  final double points;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 191,
                color: Colors.transparent,
              ),
              Container(
                height: 100,
                width: 25,
                transform: Matrix4.translationValues(0.0, 4.0, 0.0),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1)),
                child: unlocked
                    ? Image.asset(
                        'assets/images/gamification_icons/background_way_level.png',
                        width: 30,
                      )
                    : Container(),
              )
            ]),
        unlocked
            ? Container(
                child: SvgPicture.asset(
                'assets/images/gamification_icons/background_frame_level.svg',
                fit: BoxFit.fill,
                height: 200,
                color: primaryColor,
              ))
            : Container(
                child: SvgPicture.asset(
                'assets/images/gamification_icons/background_level.svg',
                fit: BoxFit.fill,
                height: 200,
                color: primaryColor,
              )),
        Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(alignment: Alignment.center, children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF10AF26),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    margin: EdgeInsets.all(6),
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        imageUrl: imagePath,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: primaryColor,
                            ),
                        height: 95,
                        width: 95,
                        cacheKey: imagePath,
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover)),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    level,
                    style: textStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${points.formattedPoints()} EXP",
                    style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
