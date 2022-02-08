import 'dart:async';
import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/home_models/balance_model.dart';
import 'package:cGamer/app/data/provider/bankslip/bankslip_provider.dart';
import 'package:cGamer/app/data/repository/bankslip_repositories/bankslip_repository.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/money_text_mask_custom.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositValueController extends GetxController {
  HomeRepository? repository;
  DepositValueController({this.repository});
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    tax.value = Get.arguments["tax"] ?? 2.0;
    type.value = Get.arguments["type"];
    balanceRequest.value = getBalance();
    super.onReady();
  }

  TedInfoModel _tedInfoModel = TedInfoModel();
  BalanceModel _balanceModel = BalanceModel();

  final type = "".obs;

  final arrayNumbers = [1, 5, 50, 100, 200];
  var moneyController = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  ).obs;

  var loading = false.obs;
  Rx<Future?> balanceRequest = Rx<Future?>(null);

  final tax = 0.0.obs;
  BankSliptRepository _repository = BankSliptRepository(
    apiClient: BankSlipApiClient(
      httpClient: Requester(),
    ),
  );

  final totalReceiveMask = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  );

  final taxMask = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  );

  final balanceAvailable = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 00.00,
    leftSymbol: "R\$ ",
  );

  final moneyValue = "R\$ 0,00".obs;

  final taxValue = "R\$ 0,00".obs;

  var totalReceive = "R\$ 0,00";

  _sumNumbers(double _value, int _index) => _value + arrayNumbers[_index];

  _calculateTotal() => moneyController.value.numberValue + tax.value;

  void displayValue(int _index) {
    var value = _sumNumbers(moneyController.value.numberValue, _index);
    _updateDepositValue(value);
    _updateTax();
    _updateTotalToReceive();
  }

  onChangeCalc(String _index) {
    var value = moneyController.value.numberValue;
    _updateDepositValue(value);
    _updateTax();
    _updateTotalToReceive();
  }

  _updateDepositValue(_value) {
    moneyController.value.updateValue(_value);
    moneyValue.value = moneyController.value.text;
  }

  _updateTax() {
    taxMask.updateValue(tax.value);
    taxValue.value = taxMask.text;
  }

  _updateTotalToReceive() {
    totalReceiveMask.updateValue(_calculateTotal());
    totalReceive = totalReceiveMask.value.text;
  }

  getBalance() async {
    loading.value = true;
    var response = await repository?.getBalance();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao buscar seu saldo, tente novamente mais tarde.",
          title: "Atenção");
    } else {
      loading.value = false;
      _balanceModel = BalanceModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      balanceAvailable.text = _balanceModel.balanceAvailable?.available ?? "";
    }
  }

  generateTicket(double _ammount) async {
    loading.value = true;
    double finalAmmount = _ammount + tax.value;
    var response = await _repository.generateTicket(finalAmmount);
    if (response is Exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado com a geração do seu boleto.",
          title: "Atenção");
    } else {
      loading.value = false;
      Get.toNamed(Routes.TICKET_VIEW, arguments: {
        "value_to_pay": _calculateTotal(),
        "payd": false,
        "ticket_info": response,
        "status": "boleto_gerado"
      });
    }
  }

  defineRoute() {
    mountObj();

    focusNode.unfocus();

    type.value == "deposit"
        ? generateTicket(moneyController.value.numberValue)
        : type.value == "transfer"
            ? Get.toNamed(Routes.TRANSFER_CHOOSE_PEOPLE, arguments: {
                'type': type.value,
                'value': moneyController.value.text
              })
            : Get.toNamed(Routes.TRANSFER_CHOOSE_PEOPLE, arguments: {
                'type': type.value,
                'value': moneyController.value.text,
                "ammount_with_tax": totalReceiveMask.value.text,
                "tax": taxValue.value
              });
  }

  mountObj() {
    _tedInfoModel.ammount = moneyController.value.text;
    _tedInfoModel.transferTax = taxValue.value;
    _tedInfoModel.ammountWithTax = totalReceiveMask.value.text;
    _tedInfoModel.method = "TED";
  }

  String defineTextButton() {
    if (type.value == "deposit") {
      return "Gerar boleto";
    }
    return "Avançar";
  }

  Widget defineCustomText() {
    if (type.value == "transfer" || type.value == "transfer_extern")
      return Padding(
          padding: const EdgeInsets.only(right: 24),
          child: FutureBuilder(
            future: balanceRequest.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CustomRichText(
                  textAlign: TextAlign.start,
                  normalText:
                      " Você possui ${_balanceModel.balanceAvailable?.available}\n",
                  customText: "Quanto você deseja transferir?",
                );
              } else {
                return CustomRichText(
                  textAlign: TextAlign.start,
                  normalText: " Você possui R\$ ---- \n",
                  customText: "Quanto você deseja transferir?",
                );
              }
            },
          ));
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: CustomRichText(
        textAlign: TextAlign.start,
        normalText: "Quanto que você quer que",
        customText: "seja depositado?",
        customText2: "",
        normalText2: "",
      ),
    );
  }

  String defineAppBarText() {
    if (type.value == "transfer" || type.value == "transfer_extern")
      return "Transferência";
    return "Depósito";
  }

  String defineTaxBoxTxt() {
    if (type.value == "deposit") return "Valor total do boleto";
    return "Valor total ";
  }

  dynamic validateBalance(String txt) {
    if (txt.isEmpty) return "Saldo igual a zero";

    if ((moneyController.value.numberValue + tax.value) >
        balanceAvailable.numberValue)
      return type.value == 'deposit' ? null : "Saldo insuficiente";

    if (moneyController.value.numberValue == 0.0
        // double.parse(
        //       moneyController.value.text.replaceAll(',', '.').split(" ")[1]
        )
      return "Valor inválido";
    else
      return null;
  }
}
