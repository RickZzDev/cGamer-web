import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/utils/generic_utils/hero_util.dart';
import 'package:flutter/material.dart';

class GiftCardItem extends StatelessWidget {
  //final GiftCardItemModel model;
  final String heroTag;
  final String urlImage;
  GiftCardItem({required this.heroTag, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ), //change to image.network
    );
  }
}
