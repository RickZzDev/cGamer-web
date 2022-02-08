import 'dart:convert';

import 'package:cGamer/app/data/models/user_account_models/register_model.dart';
import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/models/wallet_models/virtual_card_transactions.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletController extends GetxController {
  final CardRepository repository;
  WalletController({required this.repository});

  final currentIndex = 0.obs;

  final virtualCardIsVisible = false.obs;
  final hasCompletedVirtualCardDetailsRequest = false.obs;
  final hasCompletedVirtualCardTrasactionsRequest = false.obs;
  Rx<VirtualCardModel> virtualCardModel = VirtualCardModel().obs;
  Rx<PCIVirtualCardModel> pciModel = PCIVirtualCardModel().obs;
  Rx<VirtualCardTransactionsModel> virtualCardTransactions =
      VirtualCardTransactionsModel().obs;
  final isUnlockedToView = false.obs;

  @override
  void onReady() async {
    hasCompletedVirtualCardDetailsRequest.value = await getVirtualCardDetails();
    super.onReady();
  }

  @override
  void onInit() async {
    DartNotificationCenter.registerChannel(channel: 'refreshWallet');
    _subscribeListener();
    super.onInit();
  }

  _changeHasCompletedeCardRequest() =>
      hasCompletedVirtualCardDetailsRequest.value =
          !hasCompletedVirtualCardDetailsRequest.value;

  Future<void> refreshPage() async {
    _changeHasCompletedeCardRequest();
    hasCompletedVirtualCardDetailsRequest.value = await getVirtualCardDetails();
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  _subscribeListener() {
    DartNotificationCenter.subscribe(
      channel: 'refreshWallet',
      observer: this,
      onNotification: (options) {
        if (options != null) {
          pciModel.value = options['data'];
          virtualCardIsVisible.value = true;
        }
        refreshPage();
      },
    );
  }

  Future<bool> getVirtualCardDetails() async {
    try {
      var response = await repository.getVirtualCardDetails();
      virtualCardModel.value = VirtualCardModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      virtualCardModel.refresh();
      if (virtualCardModel.value.cardName != null) {
        hasCompletedVirtualCardTrasactionsRequest.value =
            await getTransactionsVirtualCard();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getTransactionsVirtualCard() async {
    try {
      var response = await repository.getVirtualCardTransactions(
          size: 3,
          startDate: getInitialDateAndFinalDate()['initialDate'],
          finalDate: getInitialDateAndFinalDate()['finalDate']);
      virtualCardTransactions.value = VirtualCardTransactionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      virtualCardTransactions.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  void copyCardNumber() {
    Clipboard.setData(ClipboardData(text: pciModel.value.cardNumber));
  }

  bool verifyDocumentsSend() {
    String? statusBankly =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .statusBanlky;
    bool hasCompleteRegistration =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .hasCompleteRegistration;
    bool hasSendDocumentation =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .hasSendDocumentation;
    if (hasCompleteRegistration &&
        hasSendDocumentation &&
        statusBankly == "APPROVED")
      return true;
    else
      return false;
  }

  Map<String, dynamic> getInitialDateAndFinalDate() {
    Map<String, dynamic> values = {};

    DateTime finalDate = DateTime.now();

    DateFormat formatter = DateFormat('yyyy-MM-dd');

    var initialDate = finalDate.subtract(Duration(days: 87));

    var formattedFinalDate = formatter.format(finalDate);

    var formattedInitialDate = formatter.format(initialDate);
    values = {
      'initialDate': formattedInitialDate,
      'finalDate': formattedFinalDate
    };
    return values;
  }

  void openWalletExtractPage() {
    Get.toNamed(Routes.WALLET_EXTRACT_CARD);
  }
}
