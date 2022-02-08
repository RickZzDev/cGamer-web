import 'dart:async';
import 'dart:io';

import 'package:cGamer/app/data/models/prime_models/prime_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase_ios/in_app_purchase_ios.dart';
import 'package:in_app_purchase_ios/store_kit_wrappers.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const String _kProMonthSubscriptionId = 'PROMENSAL';
const String _kProYearlySubscriptionId = 'PROANUAL';

const String _kProMonthSubscriptionIdAndroid = 'jogga.prime.mensal';
const String _kProYearlySubscriptionIdAndroid = 'jogga.prime.anual';

const List<String> _kProductIds = <String>[
  _kProMonthSubscriptionId,
  _kProYearlySubscriptionId,
];

const List<String> _kProductIdsAndroid = <String>[
  _kProMonthSubscriptionIdAndroid,
  _kProYearlySubscriptionIdAndroid,
];

class ProController extends GetxController {
  final ProRepository repository;
  ProController({required this.repository});
  StreamSubscription<dynamic>? _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  var loading = false.obs;
  var isSelectedMonth = true.obs;
  RxList<PurchaseDetails> _purchases = RxList();
  RxList<ProductDetails> _products = RxList();
  RxList<PrimeBenefits> benefits = RxList();
  RxList<FAQQuestion> questions = <FAQQuestion>[].obs;

  @override
  void onInit() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      List<PurchaseDetails> purchaseDetails = purchaseDetailsList;
      _listenToPurchaseUpdated(purchaseDetails);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      _handleError(error);
    });

    initStoreInfo();

    super.onInit();
  }

  @override
  void onReady() async {
    await buildBenefits();
    buildQuestions();
    super.onReady();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> buildBenefits() async {
    loading.value = true;
    try {
      var response = await repository.getBenefits();
      loading.value = false;
      if (!ExceptionUtils.verifyIfIsException(response)) {
        benefits.value = response.benefits;
        return;
      }

      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro para buscar os benefícios da assinatura.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Ocorreu um erro para buscar os benefícios da assinatura.",
          title: "Atenção");
      return;
    }
  }

  void buildQuestions() {
    FAQQuestion question = FAQQuestion();
    question.question =
        "Quais as formas de pagamentos aceitas para me tornar Jogga Prime ${Platform.isAndroid ? "pela Google Play?" : "pela Apple?"}";
    question.answer = Platform.isAndroid
        ? "Caso queira realizar seu pagamento através do seu Google Play, você pode utilizar os seguintes meios de pagamento: \n\n - A maioria dos cartões de crédito; \n - Saldo de crédito do Google Play (por meios de cartões-presente)."
        : "Caso queira realizar seu pagamento através do seu Apple ID, você pode utilizar os seguintes meios de pagamento: \n\n - A maioria dos cartões de crédito; \n - Saldo de crédito do ID Apple (por meios de cartões-presente).";
    questions.add(question);

    FAQQuestion question3 = FAQQuestion();
    question3.question = "Porque existe uma assinatura no Jogga?";
    question3.answer =
        "Desenvolver uma plataforma com qualidade não é uma tarefa fácil. Com a sua ajuda, conseguimos manter nossa plataforma e equipe, podendo oferecer a melhor experiência em novas atualizações com muitas novidades sempre!";
    questions.add(question3);

    FAQQuestion question0 = FAQQuestion();
    question0.question = "Quando libera mais bônus de Rubis para resgatar?";
    question0.answer =
        "Uma vez ao mês, é liberado o botão para resgatar bônus de Rubis, por ser assinante em sua área exclusiva do Jogga Prime.";
    questions.add(question0);

    FAQQuestion question1 = FAQQuestion();
    question1.question = "O que é o item NFT?";
    question1.answer =
        "NFT é a sigla para Non Fungible Tokens, (tokens não fungíveis), que significa, items únicos que podem ser negociados dentro do mercado de cripto-tokens. Esses itens possuem valor real, e podem ser negociados através de criptomoedas. No futuro pretendemos oferecer itens NFT`s em nosso ecossistema, e você adquirindo nosso Prime até o lançamento, irá adquirir um NFT exclusivo dos assinantes.";
    questions.add(question1);

    FAQQuestion question2 = FAQQuestion();
    question2.question =
        "Fiz minha assinatura em uma plataforma, ela vale também para as outras?";
    question2.answer =
        "Ao assinar o Jogga Prime em qualquer plataforma, sua assinatura é válida em todas as outras em que o Jogga estiver disponível.";
    questions.add(question2);

    FAQQuestion question4 = FAQQuestion();
    question4.question = "Como faço para cancelar minha assinatura?";
    question4.answer =
        "Você é livre para cancelar quando quiser, e o caminho é ir em Configurações da sua conta ${Platform.isAndroid ? "no Google Play" : "na Apple Store"}, acessar Assinaturas e solicitar o cancelamento. Sua assinatura será renovada automaticamente, ao menos que efetue o cancelamento 24h antes do término dos respectivos períodos.";
    questions.add(question4);

    FAQQuestion question5 = FAQQuestion();
    question5.question =
        "Quanto tempo demora para minha assinatura ser efetivada?";
    question5.answer =
        "Geralmente é imediato, mas pode demorar alguns minutos para que tudo seja sincronizado.";
    questions.add(question5);
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      return;
    }

    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());

      // var transactions = await SKPaymentQueueWrapper().transactions();
      // transactions.forEach((skPaymentTransactionWrapper) {
      //   SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      // });
    }

    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(Platform.isAndroid
            ? _kProductIdsAndroid.toSet()
            : _kProductIds.toSet());
    if (productDetailResponse.error == null) {
      loading.value = false;
      _products.value = productDetailResponse.productDetails;
      _purchases.value = [];
    }

    return;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        loading.value = true;
      } else {
        loading.value = false;
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  void _handleError(IAPError error) {
    loading.value = false;
    SnackBarUtils.showSnackBar(
        desc:
            'Ocorreu um erro ao tentar efetuar sua assinatura, tente novamente.',
        title: "Atenção");
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    loading.value = false;
    SnackBarUtils.showSnackBar(
        desc:
            'Ocorreu um erro ao tentar efetuar sua assinatura, tente novamente.',
        title: "Atenção");
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async {
    loading.value = false;
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      _purchases.add(purchaseDetails);
      //String svdata = purchaseDetails.verificationData.serverVerificationData;
      String purchaseId = Platform.isAndroid
          ? purchaseDetails.verificationData.serverVerificationData
          : purchaseDetails.purchaseID ?? "";
      await confirmPrime(Platform.isAndroid, purchaseId);
      return;
    }
    if (purchaseDetails.status == PurchaseStatus.restored) {
      SnackBarUtils.showSnackBar(
          desc:
              'Ocorreu uma restauração em sua conta, qualquer problema entre em contato com o suporte.',
          title: 'Verifique sua assinatura',
          color: primaryColor);
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      var priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('A alteração no preço foi aceita.'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                "Alteração do preço falhou, código do erro: ${priceChangeConfirmationResult.responseCode}",
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      var iapIosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
      await iapIosPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kProMonthSubscriptionIdAndroid &&
        purchases[_kProYearlySubscriptionIdAndroid] != null) {
      oldSubscription = purchases[_kProYearlySubscriptionIdAndroid]
          as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kProYearlySubscriptionIdAndroid &&
        purchases[_kProMonthSubscriptionIdAndroid] != null) {
      oldSubscription = purchases[_kProMonthSubscriptionIdAndroid]
          as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  Future<void> restorePurchase() async {
    loading.value = true;
    await _inAppPurchase.restorePurchases();
  }

  void buyPlan(bool isMonth) async {
    late PurchaseParam purchaseParam;

    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    ProductDetails? productDetails = getProductDetails(isMonth);

    if (productDetails == null) return;

    //String email = await Provider.of<GetStorage>(Get.context, listen: false)
    //  .read('x-email');
    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      final oldSubscription = _getOldSubscription(productDetails, purchases);

      purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails,
          //applicationUserName: email,
          changeSubscriptionParam: (oldSubscription != null)
              ? ChangeSubscriptionParam(
                  oldPurchaseDetails: oldSubscription,
                  prorationMode: ProrationMode.immediateWithTimeProration,
                )
              : null);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
        //  applicationUserName: email,
      );
    }
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  ProductDetails? getProductDetails(bool isMonth) {
    if (_products.length == 0) return null;
    ProductDetails productDetails;
    if (Platform.isIOS) {
      productDetails = _products[0].id ==
              (isMonth ? _kProMonthSubscriptionId : _kProYearlySubscriptionId)
          ? _products[0]
          : _products[1];
    } else {
      productDetails = _products[0].id ==
              (isMonth
                  ? _kProMonthSubscriptionIdAndroid
                  : _kProYearlySubscriptionIdAndroid)
          ? _products[0]
          : _products[1];
    }

    return productDetails;
  }

  String getPrice(bool isMonth) {
    ProductDetails? productDetails = getProductDetails(isMonth);
    double rawPrice = productDetails?.rawPrice ?? 0.0;
    var formatter = new NumberFormat.currency(locale: "pt_BR", symbol: "");
    return formatter.format(rawPrice);
  }

  Future<void> confirmPrime(bool isAndroid, String purchaseId) async {
    loading.value = true;
    try {
      var response;
      if (isAndroid) {
        response = await repository.confirmAndroidPrime(purchaseId);
      } else {
        response = await repository.confirmIOSPrime(purchaseId);
      }

      if (!ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;

        DartNotificationCenter.post(channel: 'refreshHome');
        SnackBarUtils.showSnackBar(
            desc:
                'Agora você é um membro Prime, acesse sua área exclusiva e desfrute dos benefícios!',
            title: 'Parabéns',
            color: primaryColor);
        return;
      }

      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao salvar sua assinatura, tente novamente mais tarde.",
          title: "Atenção");
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc:
              "Ocorreu um erro ao salvar sua assinatura, tente novamente mais tarde.",
          title: "Atenção");
      return;
    }
  }

  void goToAnswer(FAQQuestion model, String categoryTitle) async {
    Get.toNamed(Routes.FAQ_ANSWER,
        arguments: {'question_model': model, 'category_title': categoryTitle});
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
