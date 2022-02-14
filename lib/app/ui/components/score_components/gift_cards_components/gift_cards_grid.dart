import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/hero_util.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiftCardsGrid extends StatelessWidget {
  final GiftCardModel model;
  final ScoreController controller;

  GiftCardsGrid(this.model, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 24),
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.giftcards?.length ?? 0,
          primary: false,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: screenWidthhSize / 340),
          itemBuilder: (BuildContext context, int index) {
            String heroTag = HeroUtil().getUniqueId();

            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.BUY_GIFT_CARD,
                          arguments: <String, dynamic>{
                            "model": model.giftcards?[index],
                            "points": controller.scoreModelResult.value
                                .customerLevel?.customerBalancePoints,
                            "heroTag": heroTag
                          });
                    },
                    child: GiftCardItem(
                      heroTag: heroTag,
                      urlImage: model.giftcards?[index].iconUrl ?? "",
                    )));
          }),
    );
  }
}
