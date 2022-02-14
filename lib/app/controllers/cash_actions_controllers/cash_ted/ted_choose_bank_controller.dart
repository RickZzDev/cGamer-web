import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/data/models/cash_models/banks_model.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/filter_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';

class ChooseBankController extends GetxController {
  final TransferExternRepository repository;
  ChooseBankController({required this.repository});

  Rx<TedInfoModel> tedInfo = TedInfoModel().obs;

  final selected = "".obs;

  FilterUtils filterUtils = FilterUtils();

  Rx<BanksModel> banks = BanksModel().obs;

  Future? httpResponse;

  List<Banks> firstValue = [];

  @override
  void onInit() {
    tedInfo.value = Get.arguments["ted_info"];
    httpResponse = getBanks();
    super.onInit();
  }

  getBanks() async {
    var _response = await repository.getBanks();
    var exception = ExceptionUtils.verifyIfIsException(_response);
    if (exception) {
      SnackBarUtils.showSnackBar(
        desc: _response.message,
        title: "Falha ao buscar",
        color: Colors.orange[400],
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    } else {
      banks.value = _response;
      firstValue = banks.value.banks ?? [];
    }
  }

  filter(String value) {
    filterUtils.filterBanks(
        value: value, listTofilter: banks, initialListValue: firstValue);
  }

  changeSelected(String _bankName, String _bankCode) async {
    mountObj(_bankName);
    this.selected.value = _bankName;
    tedInfo.value.bank = _bankName;
    tedInfo.value.bankCode = _bankCode;
    await Future.delayed(Duration(milliseconds: 250));
    Get.toNamed(Routes.TRANSFER_TED_CHOOSE_ACCOUNT_TYPE,
        arguments: {"ted_info": tedInfo.value});
  }

  mountObj(String _value) {
    tedInfo.value.bank = _value;
  }

  Color defineColor(int _index) {
    if (selected.value == banks.value.banks?[_index].name)
      return primaryColor;
    else
      return secondaryColor;
  }
}
