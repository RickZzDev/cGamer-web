import 'package:cGamer/app/controllers/wallet_controllers/card_extract_controllers/card_extract_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components.dart';

class CardTransactionsList extends StatelessWidget {
  final CardExtractController _controller;
  CardTransactionsList(this._controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(() => _controller.transactionsHasLoaded.value
            ? _controller.filterableList == null ||
                    _controller.filterableList.length == 0
                ? Align(
                    alignment: Alignment.topLeft,
                    child: EmptyTransaction(),
                  )
                : ListView.builder(
                    itemCount: _controller.filterableList.length,
                    itemBuilder: (context, index) {
                      return LastMovimentsComponent(
                        amount: _controller.filterableList[index].amount,
                        date: _controller.filterableList[index].date,
                        title: _controller.filterableList[index].title,
                        imgSrc: _controller.filterableList[index].iconUrl,
                        toName: _controller.filterableList[index].description,
                      );
                    },
                  )
            : ListView.builder(
                itemBuilder: (context, index) =>
                    LastMovimentsComponentShimmer(),
                itemCount: 10,
              )));
  }
}
