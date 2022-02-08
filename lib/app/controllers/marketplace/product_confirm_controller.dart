import 'dart:convert';

import 'package:cGamer/app/data/models/home_models/balance_model.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ProductConfirmController extends GetxController {
  final HomeRepository repository;
  ProductConfirmController({required this.repository});

  DigitalProduct? product;
  DigitalProductDetail? productDetail;
  BalanceModel balanceModel = BalanceModel();
  var hasCompletedBalanceRequest = false.obs;
  final title = "".obs;
  final loading = false.obs;
  var isPrime = false.obs;

  @override
  void onInit() async {
    product = Get.arguments['product'];
    productDetail = Get.arguments['productDetail'];
    isPrime.value = await PrimeUtils.isPrime();
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedBalanceRequest.value = await getBalance();
    super.onReady();
  }

  Future<bool> getBalance() async {
    loading.value = true;
    var response = await repository.getBalance();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      balanceModel = BalanceModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  bool hasBalanceToBuy() {
    double value = product?.salesPrice ?? 0.0;
    String balanceString = balanceModel.balanceAvailable!.available!
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    double valueBalance = double.parse(balanceString);
    return value <= valueBalance;
  }

  // Future<dynamic> getProductDetails(DigitalProduct product) async {
  //   loading.value = true;
  //   try {
  //     var response = await repository.productDetails(product);
  //     productDetailModel.value = DigitalProductDetail.fromJson(
  //       json.decode(utf8.decode(response.bodyBytes)),
  //     );

  //     Get.toNamed(Routes.MARKETPLACE_CONFIRM_BUY, arguments: {
  //       'productDetail': productDetailModel.value,
  //       'product': product
  //     });
  //     loading.value = false;
  //   } catch (e) {
  //     loading.value = false;
  //     return Future.error(e);
  //   }
  // }
}
