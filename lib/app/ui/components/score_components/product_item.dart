import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  //final GiftCardProducts product;

  final int? id;
  final String? title;
  final String? iconProductUrl;
  final double? points;
  final Function()? onTap;
  final bool hasBalance;

  ProductItem(
      {required this.id,
      required this.title,
      required this.points,
      this.iconProductUrl,
      this.hasBalance = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  iconProductUrl ?? "",
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                )),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title ?? "",
                  style: textStyle,
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: hasBalance ? primaryColor : secondaryColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Troque por ${this.points?.toInt()} Rubis',
                    style: textStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: hasBalance
                            ? secondaryColor
                            : Colors.white.withOpacity(0.7)),
                  ),
                )
              ],
            )),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 36,
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
