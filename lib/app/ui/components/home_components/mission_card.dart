import 'package:cGamer/app/data/models/home_models/missions_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MissionCard extends StatelessWidget {
  MissionCard({missions, imgName, onTapFunction, hasBorder})
      : this._missions = missions,
        this._onTapFunction = onTapFunction,
        this.hasBorder = hasBorder;

  final Missions _missions;
  final Function _onTapFunction;
  final bool hasBorder;
  // final String _imgName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapFunction(),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            color: _missions.hasComplete
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            border: Border.all(
                width: hasBorder ? 1 : 0,
                color: Theme.of(context).primaryColor),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                child: SvgPicture.network(
                  "${_missions.iconUrl}",
                  color: _missions.hasComplete
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                ),
              ),
              Text(
                _missions.name ?? "",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(fontSize: 13, color: Colors.white),
              ),
              _missions.hasComplete
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).accentColor,
                      size: 24,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            '+${_missions.points.formattedPoints()}',
                            style: textStyle.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ]),
            ],
          )),
    );
  }
}
