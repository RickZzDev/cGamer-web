import 'package:cGamer/app/controllers/score/gift_card/gift_card_controller.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/score/payment/payment_score_controller.dart';
import '../../components.dart';

class GiftCardProductsList extends StatelessWidget {
  final GiftCardController _controller;
  final List<GiftCardProducts>? products;
  GiftCardProductsList(this.products, this._controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 8,
              ),
          itemCount: products?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(
              id: products?[index].id,
              points: products?[index].points,
              title: products?[index].title,
              iconProductUrl: products?[index].iconProductUrl,
              hasBalance: _controller.hasBalance(products?[index].points),
              onTap: () => _controller.hasBalance(products?[index].points)
                  ? Get.toNamed(Routes.PAYMENT_SCORE_PASSWORD,
                      arguments: <String, dynamic>{
                          "paymentType": PaymentType.GIFTCARD,
                          "product": _controller.model,
                          "productDetails": products?[index]
                        })
                  : SnackBarUtils.showSnackBar(
                      desc: 'Saldo insuficiente de Rubis para esta troca.',
                      title: "Atenção"),
            );
          }),
    );
  }
}
