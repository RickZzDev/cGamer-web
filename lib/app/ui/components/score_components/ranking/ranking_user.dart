import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

// ignore: must_be_immutable
class UserRanking extends StatelessWidget {
  UserRanking({required this.user, this.isMyPosition = false, this.position = -1});

  UserRankingModel? user;
  bool isMyPosition;
  int position;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        color: secondaryColor,
        width: MediaQuery.of(context).size.width,
        height: 46,
        child: Column(children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                SizedBox(
                  width: 8,
                ),
                Text(
                  isMyPosition ? '${user?.customerPosition}' : '$position',
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 12,
                ),
                CachedNetworkImage(
                    imageUrl: user?.iconLevelUrl ?? "",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
                    height: 30,
                    width: 30,
                    cacheKey: user?.iconLevelUrl ?? "",
                    useOldImageOnUrlChange: true,
                    fit: BoxFit.cover),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "@${user?.username}",
                  style: textStyle.copyWith(
                    color: user?.nickColor != null
                        ? GenericUtils.getColorWithHex(user?.nickColor ?? "")
                        : Colors.white,
                    fontWeight: position == 1
                        ? FontWeight.bold
                        : position == 2
                            ? FontWeight.bold
                            : position == 3
                                ? FontWeight.bold
                                : FontWeight.normal,
                    fontSize: position == 1
                        ? 18
                        : position == 2
                            ? 17
                            : position == 3 || isMyPosition
                                ? 16
                                : 15,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                user?.badge != null
                    ? CachedNetworkImage(
                        imageUrl: user?.badge?.image ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: primaryColor,
                            ),
                        height: 30,
                        width: 30,
                        cacheKey: user?.badge?.image ?? "",
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover)
                    : Container(),
              ]),
              Row(children: [
                Text(
                  '${user?.points.formattedPoints()}',
                  style: textStyle.copyWith(
                    fontWeight: position == 1 || isMyPosition
                        ? FontWeight.bold
                        : position == 2
                            ? FontWeight.bold
                            : position == 3
                                ? FontWeight.bold
                                : FontWeight.normal,
                    fontSize: position == 1 || isMyPosition
                        ? 20
                        : position == 2
                            ? 18
                            : position == 3
                                ? 17
                                : 16,
                  ),
                )
              ]),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ]));
  }
}
