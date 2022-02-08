import 'package:cGamer/app/controllers/score/points_extract_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/points_pendent_list.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/points_transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointsExtract extends StatefulWidget {
  PointsExtract({required this.extractController});
  final PointsExtractController extractController;

  @override
  _PointsExtractState createState() => _PointsExtractState();
}

class _PointsExtractState extends State<PointsExtract> {
  @override
  void dispose() {
    widget.extractController.indexTab.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => widget.extractController.refresh(),
        child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HorizontalChoiceComponent(
                      menuList: [
                        ItemModel(0, true, 'Confirmados'),
                        ItemModel(1, false, 'Pendentes'),
                      ],
                      onTap: (value) {
                        widget.extractController.indexTab.value = value;
                      }),
                ),
                SizedBox(height: 20),
                Obx(() => widget.extractController.indexTab.value == 0
                    ? PointsTransactionsList(widget.extractController
                            .hasCompletedTransactionsResult.value
                        ? widget.extractController.transactionsModelResult.value
                            .historyPoints
                        : null)
                    : PointsPendentList(widget.extractController
                            .hasCompletedTransactionsResult.value
                        ? widget.extractController.transactionsModelResult.value
                            .pendentPoints
                        : null))
              ],
            )));
  }
}
