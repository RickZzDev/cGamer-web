import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemBoxComponent extends StatelessWidget {
  final String? title;

  final String? situation;
  final Color situationColor;
  final bool hasSubtitle;
  final bool hasReason;
  final String? reason;
  final int gCoinsQuantity;
  final String? imagePath;
  final Function()? onTap;
  final double iconSize;
  final bool desactived;

  ItemBoxComponent({
    required this.title,
    required this.situation,
    required this.imagePath,
    required this.situationColor,
    this.gCoinsQuantity = 0,
    this.hasSubtitle = false,
    this.hasReason = false,
    this.reason,
    this.iconSize = 48,
    this.desactived = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.all(10),
        width: screenWidthhSize,
        decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: desactived ? secondaryColor : primaryColor),
            ),
            color: desactived ? Color(0xffF3F3F3) : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              imagePath ?? "",
                              height: iconSize,
                              width: iconSize,
                              color: desactived ? secondaryColor : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: textStyle.copyWith(
                            color: desactived ? secondaryColor : Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      situation != null
                          ? Text(
                              situation ?? "",
                              style: textStyle.copyWith(
                                  color: desactived
                                      ? Color(0xff757575)
                                      : situationColor,
                                  fontSize: 15),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                gCoinsQuantity > 0
                    ? Container(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/gamification_icons/cristal.png',
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              ' +' + gCoinsQuantity.toString(),
                              style: textStyle.copyWith(color: primaryColor),
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
            hasReason
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomRichText(
                        fontSize: 15,
                        customFirst: true,
                        normalText: reason ?? "",
                        customText: 'Motivo:'),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
