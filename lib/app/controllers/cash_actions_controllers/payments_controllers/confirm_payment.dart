import 'dart:convert';

import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/models/home_models/balance_model.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/money_text_mask_custom.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class ConfirmBillPaymentController extends GetxController {
  final HomeRepository homeRepository;
  ConfirmBillPaymentController({required this.homeRepository});

  BillPaymentValidateResponseModel model = BillPaymentValidateResponseModel();
  MaskedTextController barCodeController = MaskedTextController(
      mask: '00000.00000 00000.000000 00000.000000 0 00000000000000');

  var hasCompletedBalanceRequest = false.obs;
  final loading = true.obs;
  var formKey = GlobalKey<FormState>();
  BalanceModel balanceModel = BalanceModel();
  final balanceAvailableController = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  );

  final balanceAvailableMask = MyMoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 0.00,
    leftSymbol: "R\$ ",
  );

  @override
  void onInit() {
    getBalance();
    model = Get.arguments['bill_payment_model'];
    balanceAvailableController.text = model.amountFormatted ?? "";

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onInit();
  }

  void changePage() {
    Get.toNamed(
      Routes.PAYMENT_BILL_PASSWORD,
      arguments: {
        'bill_payment_model': model,
      },
    );
  }

  String getValueMask(double? value) {
    if (value == null) return "";
    var valueMask = MyMoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      precision: 2,
      initialValue: value,
      leftSymbol: "R\$ ",
    );
    return valueMask.value.text;
  }

  String getBarCode() {
    barCodeController.value = TextEditingValue(text: model.digitable ?? "");
    return barCodeController.value.text;
  }

  getBalance() async {
    var response = await homeRepository.getBalance();
    if (ExceptionUtils.verifyIfIsException(response)) {
      hasCompletedBalanceRequest.value = false;
      loading.value = false;
    } else {
      balanceModel = BalanceModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      loading.value = false;
      hasCompletedBalanceRequest.value = true;
      balanceAvailableMask.text =
          balanceModel.balanceAvailable?.available ?? "";
      formKey.currentState?.validate();
    }
  }

  validateAmmountToPay(String value) {
    if (value.isEmpty) {
      return "Valor inválido, preencha corretamente o campo para pagamento";
    }
    if (balanceAvailableController.numberValue >
        balanceAvailableMask.numberValue) {
      return "Saldo insuficiente, recarrege e tente novamente.";
    }
    if (balanceAvailableController.numberValue > model.amount!) {
      return "Valor acima do máximo (${model.amountFormatted}) para pagar o boleto";
    }

    return null;
    // if()
  }
}
