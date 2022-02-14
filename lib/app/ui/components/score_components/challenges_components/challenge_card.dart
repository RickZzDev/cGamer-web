import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class ChallengeCard extends StatelessWidget {
  ChallengeCard(
      {required this.title,
      this.description,
      this.hasCompleted = false,
      this.points,
      this.imagePath,
      this.infoTap,
      this.onTap});

  final String? title;
  final String? description;
  final String? imagePath;
  final bool hasCompleted;
  final double? points;
  final Function()? onTap;
  final Function()? infoTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: hasCompleted ? primaryColor : secondaryColor,
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(2, 4.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                        width: 48,
                        child: SvgPicture.network(
                          imagePath ?? "",
                          height: 36,
                          width: 32,
                          color: hasCompleted ? secondaryColor : primaryColor,
                        )),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "",
                          style: textStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  hasCompleted ? secondaryColor : Colors.white),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          description ?? "",
                          style: textStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        hasCompleted
                            ? Row(children: [
                                Text(
                                  'Completado',
                                  style: textStyle.copyWith(
                                      fontSize: 16,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Icon(
                                      Icons.check,
                                      color: primaryColor,
                                      size: 24,
                                    ))
                              ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Image.asset(
                                      'assets/images/gamification_icons/cristal.png',
                                      height: 18,
                                      width: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Ganhe ${points.formattedPoints()} Rubis',
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                  ])
                      ],
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 8, right: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: infoTap,
                            child: Icon(
                              Icons.info_outlined,
                              color: primaryColor,
                              size: 28,
                            ),
                          )
                        ]))
              ]),
        ));
  }
}
