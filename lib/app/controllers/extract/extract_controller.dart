import 'dart:async';

import 'package:cGamer/app/data/models/home_models/extract_model.dart';
import 'package:cGamer/app/data/repository/extract_repositories/extract_repository.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExtractController extends GetxController {
  final HomeRepository repository;
  final ExtractRepository extractRepository;
  ExtractController(
      {required this.repository, required this.extractRepository});

  Rx<ExtractModel> extractResult = ExtractModel().obs;
  Rx<ExtractModel> filteredResult = ExtractModel().obs;

  var isFilteredResult = false.obs;

  var hasCompletedExtractRequest = false.obs;
  var isLoading = false.obs;

  var atualChooseItem = 0.obs;

  //Custom Filter

  final List<dynamic> customFilterChooseItens = [
    'Últimos 15 dias',
    'Últimos 30 dias',
    'Últimos 60 dias',
    'Últimos 90 dias',
  ];

  var atualCustomFilterChooseItem = 0.obs;

  TextEditingController? initialController;
  TextEditingController? finalController;
  String? initialDateValue;
  String? finalDateValue;

  var isManuallyChoose = false.obs;

  @override
  void onInit() async {
    hasCompletedExtractRequest.value = await getExtract();

    super.onInit();
  }

  syncButtonWithDateValues(int indice) {
    if (isManuallyChoose.value) {
      isManuallyChoose.value = false;
    }
    var atualDate = DateTime.now();
    if (indice == 0) {
      DateTime decreasedValue = atualDate.subtract(Duration(days: 15));
      initialDateValue = dateFormatter(decreasedValue, false);
      initialController?.text = dateFormatter(decreasedValue, true);

      finalDateValue = dateFormatter(DateTime.now(), false);
      finalController?.text = dateFormatter(DateTime.now(), true);
    }
    if (indice == 1) {
      DateTime decreasedValue = atualDate.subtract(Duration(days: 30));
      initialDateValue = dateFormatter(decreasedValue, false);
      initialController?.text = dateFormatter(decreasedValue, true);

      finalDateValue = dateFormatter(DateTime.now(), false);
      finalController?.text = dateFormatter(DateTime.now(), true);
    }
    if (indice == 2) {
      DateTime decreasedValue = atualDate.subtract(Duration(days: 60));
      initialDateValue = dateFormatter(decreasedValue, false);
      initialController?.text = dateFormatter(decreasedValue, true);

      finalDateValue = dateFormatter(DateTime.now(), false);
      finalController?.text = dateFormatter(DateTime.now(), true);
    }
    if (indice == 3) {
      DateTime decreasedValue = atualDate.subtract(Duration(days: 90));
      initialDateValue = dateFormatter(decreasedValue, false);
      initialController?.text = dateFormatter(decreasedValue, true);

      finalDateValue = dateFormatter(DateTime.now(), false);
      finalController?.text = dateFormatter(DateTime.now(), true);
    }
  }

  bool verification() {
    var finalDateToDateTime = DateTime.parse(finalDateValue!);
    var initialDateToDateTime = DateTime.parse(initialDateValue!);
    if (finalDateToDateTime.isBefore(initialDateToDateTime)) {
      SnackBarUtils.showSnackBar(
          desc: 'A data inicial não pode ser após a data final.',
          title: 'Atenção');
      return false;
    }
    return true;
  }

  String getInitialDayOnInit() {
    DateTime atualDate = DateTime.now();
    var decreasedVale = atualDate.subtract(Duration(days: 15));

    var formattedDate = dateFormatter(decreasedVale, true);

    initialDateValue = dateFormatter(decreasedVale, false);

    return formattedDate;
  }

  DateTime getTodayDecreasedDays() {
    var dateNow = DateTime.now();
    var decreased = dateNow.subtract(Duration(days: 90));
    return decreased;
  }

  String dateFormatter(DateTime date, bool brazilPattern) {
    if (brazilPattern) {
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      String formattedDate = formatter.format(date);
      return formattedDate;
    } else {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(date);
      return formattedDate;
    }
  }

  getDateFromMap(bool isInitial, {BuildContext? context}) async {
    if (isInitial) {
      await showDatePicker(
              context: Get.context!,
              fieldLabelText: 'EDITAR MANUALMENTE',
              helpText: 'SELECIONA A DATA',
              initialDate: DateTime.parse(initialDateValue!),
              firstDate: getTodayDecreasedDays(),
              lastDate: DateTime.now())
          .then((value) {
        if (value != null) {
          initialController?.text = dateFormatter(value, true);
          initialDateValue = dateFormatter(value, false);
          isManuallyChoose.value = true;
        }
      });
    } else {
      await showDatePicker(
              context: Get.context!,
              fieldLabelText: 'EDITAR MANUALMENTE',
              helpText: 'SELECIONA A DATA',
              initialDate: DateTime.parse(finalDateValue!),
              firstDate: getTodayDecreasedDays(),
              lastDate: DateTime.now())
          .then((value) {
        if (value != null) {
          finalController?.text = dateFormatter(value, true);
          finalDateValue = dateFormatter(value, false);
          isManuallyChoose.value = true;
        }
      });
    }
  }

  Future getCustomExtract(String initialDate, String finalDate) async {
    isLoading.value = true;
    try {
      extractResult.value = await extractRepository
          .getCustomFilteredTransactions(initialDate, finalDate);

      isLoading.value = false;
    } catch (e) {
      throw Future.error(e);
    }
  }

  Future<bool> getExtract() async {
    isLoading.value = true;
    try {
      extractResult.value =
          await extractRepository.getStandardTransactions(); //The last 7 days
      isLoading.value = false;

      return true;
    } catch (e) {
      isLoading.value = false;
      throw Future.error(e);
    }
  }

  filterExtract({required ExtractModel model, required int type}) {
    List<TransactionExtract> _transactions = [];

    if (type == 0) {
      if (isFilteredResult.value == true) {
        isFilteredResult.value = false;
      }
    }

    if (type == 1) {
      isFilteredResult.value = true;
      model.transactions?.forEach((element) {
        if (element.type == 'CASH_IN_ACCOUNT') {
          _transactions.add(element);
        }
        filteredResult.value.transactions = _transactions;
      });
    }

    if (type == 2) {
      isFilteredResult.value = true;
      model.transactions?.forEach((element) {
        if (element.type == 'CASH_OUT_ACCOUNT' || element.type == 'PAYBILL') {
          _transactions.add(element);
        }
        filteredResult.value.transactions = _transactions;
      });
    }
    filteredResult.refresh();
  }

  showExtractDetailsModel(BuildContext context,
      {required TransactionExtract? transactionExtract, int? index}) {
    final details = transactionExtract?.details;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ExtractDetailsModal(
            transactionExtract: transactionExtract,
            details: details,
          );
        });
  }
}
