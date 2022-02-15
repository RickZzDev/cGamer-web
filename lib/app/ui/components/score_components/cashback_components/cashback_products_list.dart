import 'package:cGamer/app/controllers/score/cashback/cashback_controller.dart';
import 'package:cGamer/app/controllers/score/payment/payment_score_controller.dart';
import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/score_components/product_item.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashBackProductsList extends StatelessWidget {
  final List<CashBackProduct>? products;
  final CashbackController _controller;

  CashBackProductsList(this.products, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) => ProductItem(
              onTap: () {
                if (!_controller.isValidAccount()) {
                  SnackBarUtils.showSnackBar(
                      desc: "Para acessar é necessário ativar sua conta",
                      title: "Atenção.");
                } else {
                  if (_controller.hasBalance(products?[index].points)) {
                    Get.toNamed(Routes.PAYMENT_SCORE_PASSWORD,
                        arguments: <String, dynamic>{
                          "paymentType": PaymentType.CASHBACK,
                          "product": products?[index]
                        });
                    return;
                  }
                  SnackBarUtils.showSnackBar(
                      desc: "Você não tem saldo suficiente.",
                      title: "Atenção.");
                }
              },
              iconProductUrl: products?[index].iconProductUrl,
              hasBalance: _controller.hasBalance(products?[index].points),
              id: products?[index].id,
              title: products?[index].title,
              points: products?[index].points),
          separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
          itemCount: products?.length ?? 0),
    );
  }
}
