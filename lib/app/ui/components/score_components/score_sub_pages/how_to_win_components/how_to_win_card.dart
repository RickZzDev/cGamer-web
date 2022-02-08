import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HowToWinCard extends StatelessWidget {
  final String? imgSrc;
  final String? text;
  final String? description;
  final String? earnPoints;
  final Function()? onTap;
  final bool hasBorder;
  final bool isTrophy;
  final bool isPrime;
  const HowToWinCard(
      {Key? key,
      this.hasBorder = false,
      this.description,
      this.earnPoints,
      required this.imgSrc,
      required this.text,
      required this.onTap,
      this.isTrophy = false,
      this.isPrime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: hasBorder
                  ? BorderSide(color: primaryColor, width: 0.5)
                  : BorderSide.none),
        ),
        padding: EdgeInsets.only(left: screenWidthhSize * 0.01),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  child: SvgPicture.asset(imgSrc ?? "",
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text ?? "",
                        style: textStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      description != null
                          ? Text(
                              description ?? "",
                              style: textStyle.copyWith(
                                fontSize: 12,
                                color: Colors.white54,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 4,
                      ),
                      earnPoints != null
                          ? Row(children: [
                              Image.asset(
                                isTrophy
                                    ? 'assets/images/gamification_icons/trophy.png'
                                    : 'assets/images/gamification_icons/cristal.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                earnPoints ?? "",
                                style: textStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              isPrime && !isTrophy
                                  ? Container(
                                      margin: EdgeInsets.only(left: 4),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF131313),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Text('X2',
                                          style:
                                              textStyle.copyWith(fontSize: 12)))
                                  : Container()
                            ])
                          : Container(),
                      SizedBox(
                        height: 4,
                      ),
                    ]),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
