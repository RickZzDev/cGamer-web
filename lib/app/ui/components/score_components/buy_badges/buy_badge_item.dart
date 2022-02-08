import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class BuyBadgeItem extends StatelessWidget {
  BuyBadgeItem(
      {required this.title,
      this.description,
      this.imagePath,
      this.sellPoints,
      this.isSelected,
      this.hasContains = false,
      this.onTap});

  final String title;
  final String? description;
  final String? imagePath;
  final double? sellPoints;
  final bool? isSelected;
  final bool hasContains;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: SvgPicture.asset(
                  isSelected ?? false
                      ? 'assets/images/gamification_icons/moldura_badge_selected.svg'
                      : 'assets/images/gamification_icons/moldura_badge.svg',
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  fit: BoxFit.fitWidth,
                )),
            Container(
              height: 150,
              // decoration: BoxDecoration(
              //   color: isSelected ? primaryColor : secondaryColor,
              //   border: Border.all(color: primaryColor),
              //   borderRadius: BorderRadius.circular(10),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withOpacity(0.4),
              //       offset: Offset(2, 4.0), //(x,y)
              //       blurRadius: 2.0,
              //     ),
              //   ],
              // ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                        imageUrl: imagePath ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 100,
                        width: 100,
                        cacheKey: imagePath,
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        !hasContains
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Image.asset(
                                      'assets/images/gamification_icons/cristal.png',
                                      height: 16,
                                      width: 16,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${sellPoints.formattedPoints()}',
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          color: isSelected ?? false
                                              ? Colors.white
                                              : primaryColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ])
                            : Container(
                                height: 16,
                              ),
                        Text(
                          title,
                          style: textStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ?? false
                                  ? Colors.white
                                  : primaryColor),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          description ?? "",
                          style: textStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        hasContains
                            ? Text(
                                'Badge já adquirido',
                                style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: isSelected ?? false
                                        ? Colors.white
                                        : primaryColor),
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
