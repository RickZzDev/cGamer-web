import 'package:cGamer/app/data/models/wallet_models/virtual_card_transactions.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_extract_repositories/card_extract_repository.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum FILTER_TYPE { CASH_OUT_ACCOUNT, CASH_IN_ACCOUNT }

class CardExtractController extends GetxController {
  final CardExtractRepository repository;
  CardExtractController({required this.repository});

  var transactionsHasLoaded = false.obs;

  List<VirtualCardTransaction> listTransactions = [];
  RxList<VirtualCardTransaction> filterableList =
      <VirtualCardTransaction>[].obs;

  var atualIndex = 0.obs;

  final List<String> customFilterChooseItens = [
    'Últimos 15 dias',
    'Últimos 30 dias',
    'Últimos 60 dias',
    'Últimos 90 dias',
  ];
  var atualCustomFilterChooseItem = 0.obs;
  var isManuallyChoose = false.obs;

  TextEditingController? initialController;
  TextEditingController? finalController;
  String? initialDateValue;
  String? finalDateValue;

  @override
  void onInit() async {
    transactionsHasLoaded.value = await getCardExtract();

    atualIndex.listen((index) {
      if (index == 0) {
        filterableList.value = listTransactions;
        print(filterableList.length);
      }
      if (index == 1) {
        filter(FILTER_TYPE.CASH_IN_ACCOUNT);
        print(filterableList.length);
      }

      if (index == 2) {
        filter(FILTER_TYPE.CASH_OUT_ACCOUNT);
        print(filterableList.length);
      }
    });

    super.onInit();
  }

  void filter(FILTER_TYPE type) {
    List<VirtualCardTransaction> _list = [];
    switch (type) {
      case FILTER_TYPE.CASH_IN_ACCOUNT:
        listTransactions.forEach((element) {
          if (element.type == "CASH_IN_ACCOUNT") {
            _list.add(element);
          }
        });
        filterableList.value = _list;
        break;
      case FILTER_TYPE.CASH_OUT_ACCOUNT:
        listTransactions.forEach((element) {
          if (element.type == "CASH_OUT_ACCOUNT") {
            _list.add(element);
          }
        });
        filterableList.value = _list;
        break;
      default:
        print("Error with type");
    }
  }

  Future<bool> getCardExtract() async {
    try {
      VirtualCardTransactionsModel model = await repository.getCardExtract();
      listTransactions = model.transactions ?? [];
      filterableList.value = model.transactions ?? [];
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(desc: e.toString(), title: "Atenção");
      return false;
    }
  }

  Future<void> getCustomExtract(String initialDate, String finalDate) async {
    transactionsHasLoaded.value = false;
    try {
      var response =
          await repository.getCustomCardExtract(initialDate, finalDate);

      listTransactions = response.transactions ?? [];
      filterableList.value = listTransactions;

      transactionsHasLoaded.value = true;
    } catch (e) {
      transactionsHasLoaded.value = true;
    }
  }

  void showDetailsModal(
      BuildContext context, VirtualCardTransaction transaction) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CardDetaisModal(
            transaction: transaction,
          );
        });
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
              initialDate:
                  DateTime.parse(initialDateValue ?? DateTime.now().toString()),
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
              initialDate:
                  DateTime.parse(finalDateValue ?? DateTime.now().toString()),
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

  DateTime getTodayDecreasedDays() {
    var dateNow = DateTime.now();
    var decreased = dateNow.subtract(Duration(days: 90));
    return decreased;
  }

  bool verification() {
    var finalDateToDateTime =
        DateTime.parse(finalDateValue ?? DateTime.now().toString());
    var initialDateToDateTime =
        DateTime.parse(initialDateValue ?? DateTime.now().toString());
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

  void initConfig(TextEditingController _initialController,
      TextEditingController _finalController) {
    if (_finalController.text.isEmpty && finalDateValue == null) {
      _finalController.text = dateFormatter(DateTime.now(), true);
      finalDateValue = dateFormatter(DateTime.now(), false);
      finalController = _finalController;
    }
    if (_initialController.text.isEmpty && initialDateValue == null) {
      _initialController.text = getInitialDayOnInit();
      initialController = _initialController;
    }

    if (isManuallyChoose.value) {
      atualCustomFilterChooseItem.value = 5;
    }
  }
}
