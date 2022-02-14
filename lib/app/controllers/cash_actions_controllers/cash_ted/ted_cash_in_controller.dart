import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'dart:convert';
import 'package:cGamer/app/data/repository/cash_in_repositories/cash_in_ted_repository.dart';
import 'package:share/share.dart';

class CashInTedController extends GetxController {
  final CashInTedRepository repository;
  CashInTedController({required this.repository});

  Rx<Future<bool>> hasCompletedBankAccountRequest = Future.value(false).obs;
  Rx<ProfileModel> statusBankAccountResult = ProfileModel().obs;

  final allComplete = false.obs;

  changeAllComplete({bool valueAllComplete = true}) =>
      this.allComplete.value = valueAllComplete;

  @override
  void onReady() async {
    hasCompletedBankAccountRequest.value = getProfile();
    super.onReady();
  }

  Future<bool> getProfile() async {
    var response = await repository.getBankAccount();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      statusBankAccountResult.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  void copyAgency() {
    Clipboard.setData(ClipboardData(
        text: statusBankAccountResult.value.customerAccount?.agency));
  }

  void copyAccountNumber() {
    Clipboard.setData(ClipboardData(
        text: statusBankAccountResult.value.customerAccount?.account));
  }

  void copyCPF() {
    Clipboard.setData(
        ClipboardData(text: statusBankAccountResult.value.customerCPF));
  }

  void shareBankAccount() {
    Share.share(GenericUtils.getMessageShare(statusBankAccountResult.value));
  }
}
