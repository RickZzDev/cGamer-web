import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class LevelsBenefitsComponent extends StatelessWidget {
  final AllLevelModel level;
  final bool isCurrentLevel;
  LevelsBenefitsComponent({required this.level, required this.isCurrentLevel});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: isCurrentLevel ? Theme.of(context).primaryColor : Colors.white54,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(2, 4.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${level.customerLevel}',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "${level.customerPoints.formattedPoints()} Rubis",
                              style: textStyle.copyWith(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                              )),
                        ]),
                    !(level.unlocked ?? false)
                        ? SizedBox(
                            height: 30,
                            child: SvgPicture.asset(
                              "assets/images/profile_images/my_progress_images/padlock.svg",
                              color: Theme.of(context).accentColor,
                            ),
                          )
                        : SizedBox(
                            height: 30,
                            child: Icon(
                              Icons.check,
                              size: 30,
                              color: Theme.of(context).accentColor,
                            ),
                          )
                  ]),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Theme.of(context).accentColor,
                height: 4,
              ),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: level.benefits?.length ?? 0,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          child: Text("${level.benefits?[index]}",
                              style: textStyle.copyWith(
                                fontSize: 14,
                                color: Theme.of(context).accentColor,
                              ))),
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
