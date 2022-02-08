import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class RankingTop3 extends StatelessWidget {
  const RankingTop3({
    Key? key,
    required List<UserRankingModel> ranking,
  })  : _ranking = ranking,
        super(key: key);

  final List<UserRankingModel> _ranking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, bottom: 24, top: 0, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0c8a1e),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(
                          6,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: _ranking[1].iconLevelUrl ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
                        height: 75,
                        width: 75,
                        cacheKey: _ranking[1].iconLevelUrl,
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(-40.0, -12.0, 0.0),
                        child: Text('2º',
                            style: textStyle.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text('@${_ranking[1].username}',
                    style: textStyle.copyWith(
                        fontSize: 16,
                        color: _ranking[1].nickColor != null
                            ? GenericUtils.getColorWithHex(
                                _ranking[1].nickColor ?? "")
                            : Colors.white)),
                SizedBox(
                  height: 4,
                ),
                Row(children: [
                  Image.asset(
                    'assets/images/gamification_icons/cristal.png',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('${_ranking[1].points.formattedPoints()}',
                      style: textStyle.copyWith(fontSize: 18))
                ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 0,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0c8a1e),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(
                          6,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: _ranking[0].iconLevelUrl ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
                        height: 75,
                        width: 75,
                        cacheKey: _ranking[0].iconLevelUrl,
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(-40.0, -12.0, 0.0),
                        child: Text('1º',
                            style: textStyle.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text('@${_ranking[0].username}',
                    style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _ranking[0].nickColor != null
                            ? GenericUtils.getColorWithHex(
                                _ranking[0].nickColor ?? "")
                            : Colors.white)),
                SizedBox(
                  height: 4,
                ),
                Row(children: [
                  Image.asset(
                    'assets/images/gamification_icons/cristal.png',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('${_ranking[0].points.formattedPoints()}',
                      style: textStyle.copyWith(fontSize: 18))
                ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0c8a1e),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(
                          6,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: _ranking[2].iconLevelUrl ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
                        height: 75,
                        width: 75,
                        cacheKey: _ranking[2].iconLevelUrl,
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(-40.0, -12.0, 0.0),
                        child: Text('3º',
                            style: textStyle.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text('@${_ranking[2].username}',
                    style: textStyle.copyWith(
                        fontSize: 16,
                        color: _ranking[2].nickColor != null
                            ? GenericUtils.getColorWithHex(
                                _ranking[2].nickColor ?? "")
                            : Colors.white)),
                SizedBox(
                  height: 4,
                ),
                Row(children: [
                  Image.asset(
                    'assets/images/gamification_icons/cristal.png',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('${_ranking[2].points.formattedPoints()}',
                      style: textStyle.copyWith(fontSize: 18))
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
