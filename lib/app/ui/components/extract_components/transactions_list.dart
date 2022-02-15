import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsList extends StatelessWidget {
  final ExtractController _controller;

  TransactionsList(this._controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Obx(() => _controller.isLoading.value
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      LastMovimentsComponentShimmer(),
                  itemCount: 10,
                )
              : _controller.isFilteredResult.value
                  ? listTransactionsIsEmpty(
                          _controller.extractResult.value.transactions)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: EmptyTransaction(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) =>
                              LastMovimentsComponent(
                            onClick: () => _hasDetails(_controller
                                    .filteredResult
                                    .value
                                    .transactions?[index]
                                    .details)
                                ? _controller.showExtractDetailsModel(context,
                                    transactionExtract: _controller
                                        .filteredResult
                                        .value
                                        .transactions?[index],
                                    index: index)
                                : null,
                            imgSrc: _controller.filteredResult.value
                                    .transactions?[index].iconUrl ??
                                "", //imgs[index],
                            date: _controller.filteredResult.value
                                    .transactions?[index].date ??
                                "",
                            title: _controller.filteredResult.value
                                    .transactions?[index].title ??
                                "",
                            toName: _controller.filteredResult.value
                                    .transactions?[index].description ??
                                "",
                            amount: _controller.filteredResult.value
                                    .transactions?[index].amount
                                    .toString() ??
                                "",
                          ),
                          itemCount: _controller
                              .filteredResult.value.transactions?.length,
                        )
                  : listTransactionsIsEmpty(
                          _controller.extractResult.value.transactions)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: EmptyTransaction(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) =>
                              LastMovimentsComponent(
                            onClick: () => _hasDetails(_controller.extractResult
                                    .value.transactions?[index].details)
                                ? _controller.showExtractDetailsModel(context,
                                    transactionExtract: _controller
                                        .extractResult
                                        .value
                                        .transactions?[index],
                                    index: index)
                                : null,
                            imgSrc: _controller.extractResult.value
                                    .transactions?[index].iconUrl ??
                                "", //imgs[index],
                            date: _controller.extractResult.value
                                    .transactions?[index].date ??
                                "",
                            title: _controller.extractResult.value
                                    .transactions?[index].title ??
                                "",
                            toName: _controller.extractResult.value
                                    .transactions?[index].description ??
                                "",
                            amount: _controller.extractResult.value
                                    .transactions?[index].amount
                                    .toString() ??
                                "",
                          ),
                          itemCount: _controller
                                  .extractResult.value.transactions?.length ??
                              0,
                        ))),
    );
  }

  bool listTransactionsIsEmpty(List<TransactionExtract>? list) {
    if (list?.length == 0) {
      return true;
    }
    return false;
  }

  bool _hasDetails(Details? details) {
    if (details != null) {
      return true;
    }
    return false;
  }
}
