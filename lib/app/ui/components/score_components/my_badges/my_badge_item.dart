import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBadgeItem extends StatelessWidget {
  MyBadgeItem(
      {required this.title,
      this.description,
      this.imagePath,
      this.isSelected = false,
      this.isSvg = false,
      this.onTap});

  final String? title;
  final String? description;
  final String? imagePath;
  final bool isSelected;
  final Function()? onTap;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: SvgPicture.asset(
                isSelected
                    ? 'assets/images/gamification_icons/moldura_badge_selected.svg'
                    : 'assets/images/gamification_icons/moldura_badge.svg',
                color: primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 150,
                fit: BoxFit.fitWidth,
              )),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isSvg
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.network(
                            imagePath ?? "",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            color: isSelected ? secondaryColor : primaryColor,
                          ))
                      : CachedNetworkImage(
                          imageUrl: imagePath ?? "",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 80,
                          width: 80,
                          cacheKey: imagePath,
                          useOldImageOnUrlChange: true,
                          fit: BoxFit.cover),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title ?? "",
                        style: textStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : primaryColor),
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
                    ],
                  )),
                ],
              ),
            ),
          )
        ]));
  }
}
