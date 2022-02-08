import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GamerListItem extends StatelessWidget {
  final FriendInvite? model;
  final Function(int?) onTap;
  GamerListItem(this.model, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap(model?.customerId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: model?.avatar ??
                    "https://i.ibb.co/x5CpK1w/image-profile.png",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: primaryColor,
                    ),
                height: 48,
                width: 48,
                cacheKey: model?.avatar ??
                    "https://i.ibb.co/x5CpK1w/image-profile.png",
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.nickName ?? "",
                    style: textStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model?.isEmbaixador ?? false
                          ? Container(
                              margin: EdgeInsets.only(right: 4),
                              child: TagEmbaixador(
                                fontSize: 11.0,
                              ))
                          : Container(),
                      model?.isPrime ?? false
                          ? Container(
                              margin: EdgeInsets.only(top: 2, right: 4),
                              child: TagPrime(
                                fontSize: 11.0,
                              ))
                          : Container(),
                      Text(
                        model?.userName != null && model?.userName != ""
                            ? "@${model?.userName}"
                            : "N/A",
                        style: textStyle.copyWith(
                            fontSize: 15, color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
