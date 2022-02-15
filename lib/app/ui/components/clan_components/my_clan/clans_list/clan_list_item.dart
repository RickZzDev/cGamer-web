import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ClanListItem extends StatelessWidget {
  final ClanModel? model;
  final Function(int?) onTap;
  ClanListItem(this.model, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap(model?.id);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: model?.image ?? "",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: primaryColor,
                    ),
                height: 40,
                width: 40,
                cacheKey: model?.image ?? "",
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.name ?? "",
                    style: textStyle,
                  ),
                  Text(
                    '${model?.qtdMembers}/30 membro(s)',
                    style:
                        textStyle.copyWith(fontSize: 14, color: Colors.white70),
                  )
                ],
              ),
            ),
            Row(children: [
              Image.asset(
                'assets/images/gamification_icons/trophy.png',
                height: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                model?.qtdTrophy.toString() ?? "",
                style: textStyle.copyWith(fontSize: 14),
              )
            ])
          ],
        ),
      ),
    );
  }
}
