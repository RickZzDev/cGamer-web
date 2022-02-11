import 'dart:convert';

import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/data/models/score_models/payment_giftcard_models/payment_giftcard_model.dart';
import 'package:cGamer/app/data/repository/score_repository/payment_score_repository/payment_score_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum PaymentType { CASHBACK, GIFTCARD }

class PaymentScoreController extends GetxController {
  PaymentType? paymentType;

  final PaymentScoreRepository repository;

  PaymentScoreController(this.repository);

  CashBackProduct? cashBackProduct;

  GiftCardItemModel? giftCardProduct;
  GiftCardProducts? giftCardProductDetails;
  PaymentGiftcardModel? paymentGiftcardModel;

  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    setup();
    super.onInit();
  }

  void setup() {
    paymentType = Get.arguments['paymentType'];

    if (paymentType == PaymentType.CASHBACK) {
      cashBackProduct = Get.arguments['product'];
    }

    if (paymentType == PaymentType.GIFTCARD) {
      giftCardProduct = Get.arguments['product'];
      giftCardProductDetails = Get.arguments['productDetails'];
    }
  }

  bool passwordIsValid({String? value}) {
    if (value == null || value.isEmpty || value.length < 8) {
      return false;
    }
    return true;
  }

  Future postGiftCardPurchase() async {
    isLoading.value = true;
    try {
      var response = await repository.postGiftCardProduct(
          passwordController.text, giftCardProductDetails?.id ?? 0);

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção.");
        isLoading.value = false;
        return;
      }

      if (response.statusCode == 200) {
        paymentGiftcardModel = PaymentGiftcardModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        toSucessPageGiftCard();
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado, tente novamente.", title: "Atenção.");

      isLoading.value = false;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado, tente novamente.", title: "Atenção.");
      isLoading.value = false;
    }
  }

  Future postCashbackPurchase() async {
    isLoading.value = true;
    try {
      var response = await repository.postCashbackPurchase(
          passwordController.text, cashBackProduct?.id ?? 0);

      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção.");
        isLoading.value = false;
        return;
      }

      if (response.statusCode == 200) {
        toSucessPageCashback();
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado, tente novamente.", title: "Atenção.");

      isLoading.value = false;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo deu errado, tente novamente.", title: "Atenção.");
      isLoading.value = false;
    }
  }

  void toSucessPageGiftCard() {
    Get.offAllNamed(Routes.TRADE_SUCESS, arguments: <String, dynamic>{
      "paymentType": PaymentType.GIFTCARD,
      "giftCardProductDetails": giftCardProductDetails,
      "giftCardProduct": giftCardProduct,
      "paymentGiftcardModel": paymentGiftcardModel
    });
    setupNextScreen();
  }

  void toSucessPageCashback() {
    Get.offAllNamed(Routes.TRADE_SUCESS, arguments: <String, dynamic>{
      "paymentType": PaymentType.CASHBACK,
      "cashbackProduct": cashBackProduct
    });
    setupNextScreen();
  }

  void setupNextScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void onTap() async {
    if (passwordIsValid(value: passwordController.text)) {
      if (paymentType == PaymentType.CASHBACK) {
        await postCashbackPurchase();
        return;
      }
      if (paymentType == PaymentType.GIFTCARD) {
        await postGiftCardPurchase();
        return;
      }
    }
    SnackBarUtils.showSnackBar(
        desc: "Insira uma senha válida", title: "Atenção");
  }
}
