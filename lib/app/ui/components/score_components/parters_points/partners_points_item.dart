import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class PartnersPointsItem extends StatelessWidget {
  PartnersPointsItem(
      {required this.title,
      this.description,
      this.imagePath,
      this.earnPoints,
      this.isPrime = false,
      this.onTap});

  final String? title;
  final String? description;
  final String? imagePath;
  final String? earnPoints;
  final bool isPrime;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: secondaryColor,
                border: Border.all(color: primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(2, 4.0), //(x,y)
                    blurRadius: 2.0,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                          imageUrl: imagePath ?? "",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 75,
                          width: 75,
                          cacheKey: imagePath ?? "",
                          useOldImageOnUrlChange: true,
                          fit: BoxFit.fill)),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description ?? "",
                        style: textStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/gamification_icons/cristal.png',
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              ' Ganhe ',
                              style: textStyle.copyWith(
                                  color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              earnPoints ?? "",
                              style: textStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Rubis',
                              style: textStyle.copyWith(
                                  color: Colors.white, fontSize: 16),
                            ),
                            isPrime
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
                          ]),
                    ],
                  )),
                ],
              ),
            ),
          )
        ]));
  }
}
