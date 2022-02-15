import 'package:cGamer/app/data/models/clans_models/clan_ranking_model.dart';
import 'package:cGamer/app/data/models/score_models/ranking_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ClanRankingItem extends StatelessWidget {
  ClanRankingItem(
      {required this.cla,
      this.position = -1,
      required this.userHasClan,
      required this.isOWnCla});
  bool userHasClan;
  bool isOWnCla;
  ClanRanking? cla;
  int position;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // TODO: Consertar forma como esta abrindo, não esta instanciando uma nova tela de detalhe por ja existir uma.
          // Verificar possibilidades para conseguir abrir essa tela com os novos argumentos.
          if (isOWnCla) {
            Get.toNamed(Routes.CLAN_DETAILS,
                preventDuplicates: false,
                arguments: {'clanId': cla?.id, 'userHasClan': true});
            return;
          }

          Get.toNamed(Routes.OTHER_CLAN,
              preventDuplicates: false,
              arguments: {'clanId': cla?.id, 'userHasClan': userHasClan});
        },
        child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            color: secondaryColor,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      '#$position',
                      style: textStyle.copyWith(
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
                                  : position == 3
                                      ? 16
                                      : 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CachedNetworkImage(
                        imageUrl: cla?.image ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: primaryColor,
                            ),
                        height: 40,
                        width: 40,
                        cacheKey: cla?.image ?? "",
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.contain),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${cla?.name}",
                      style: textStyle.copyWith(
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
                                : position == 3
                                    ? 16
                                    : 15,
                      ),
                    ),
                  ]),
                  Row(children: [
                    Image.asset(
                      'assets/images/gamification_icons/trophy.png',
                      height: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      cla?.qtdTrophy != null ? "${cla?.qtdTrophy}" : "0",
                      style: textStyle.copyWith(
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
                                  : position == 3
                                      ? 16
                                      : 15),
                    )
                  ]),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ])));
  }
}
