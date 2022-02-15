import 'package:cGamer/app/controllers/score/payment/payment_score_controller.dart';
import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:cGamer/app/data/models/score_models/payment_giftcard_models/payment_giftcard_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/score_components/gift_cards_components/gift_card_item.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TradeSucessController extends GetxController {
  PaymentType? paymentType;

  bool hasCode = false;

  String? tradeCode;

  GiftCardProducts? giftCardProductDetails;
  GiftCardItemModel? giftCardProduct;
  PaymentGiftcardModel? paymentGiftcardModel;

  CashBackProduct? cashbackProduct;

  @override
  void onInit() {
    setup();
    super.onInit();
  }

  void setup() {
    this.paymentType = Get.arguments['paymentType'];

    if (this.paymentType == PaymentType.CASHBACK) {
      cashbackProduct = Get.arguments['cashbackProduct'];
    }

    if (this.paymentType == PaymentType.GIFTCARD) {
      giftCardProductDetails = Get.arguments['giftCardProductDetails'];
      giftCardProduct = Get.arguments['giftCardProduct'];
      paymentGiftcardModel = Get.arguments['paymentGiftcardModel'];

      if (paymentGiftcardModel?.transaction != null) {
        //Hype
        hasCode = false;
      } else {
        //RvHub
        hasCode = true;
        tradeCode = paymentGiftcardModel?.pin ?? "";
      }
    }
  }

  void copyCodeToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    SnackBarUtils.showSnackBar(
        color: primaryColor,
        title: "Atenção",
        desc: "PIN copiado com sucesso.");
  }

  String getCurrentDate() {
    DateTime atualDate = DateTime.now();
    String currentDate = DateFormatterUtils.brazilPatternString(atualDate);
    return currentDate;
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  void backToHome() {
    Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
    setupNextScreen();
  }

  void setupNextScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
