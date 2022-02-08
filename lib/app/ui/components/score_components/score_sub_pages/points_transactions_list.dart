import 'package:cGamer/app/controllers/wallet_controllers/card_extract_controllers/card_extract_controller.dart';
import 'package:cGamer/app/data/models/score_models/points_transaction_model.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/points_transactions_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components.dart';

class PointsTransactionsList extends StatelessWidget {
  final List<PointsTransaction>? pointsList;
  PointsTransactionsList(this.pointsList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: pointsList != null
            ? pointsList?.length == 0
                ? ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: EmptyTransaction(),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: pointsList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return PointsTransactionItem(
                        amount: pointsList?[index].points.toString(),
                        date: pointsList?[index].date,
                        title: pointsList?[index].title,
                        operationType: pointsList?[index].operationType,
                        toName: pointsList?[index].description ?? "TESTE",
                      );
                    },
                  )
            : ListView.builder(
                itemBuilder: (context, index) =>
                    LastMovimentsComponentShimmer(),
                itemCount: 10,
              ));
  }
}
