import 'dart:convert';

import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/models/market_place_model/marketplace_model.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketPlacePasswordController extends GetxController {
  final MarketPlaceRepository repository;
  MarketPlacePasswordController({required this.repository});

  final loading = false.obs;
  DigitalProduct? product;
  DigitalProductDetail? productDetail;
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    product = Get.arguments['product'];
    productDetail = Get.arguments['productDetail'];
    super.onInit();
  }

  void purchase() async {
    loading.value = true;
    var password = passwordController.value.text;
    var _response = await repository.purchase(product!, password);
    var exception = ExceptionUtils.verifyIfIsException(_response);
    if (exception) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
        desc: _response.message,
        title: "Atenção",
      );
    } else {
      loading.value = false;
      MarketplacePurchaseResponse response =
          MarketplacePurchaseResponse.fromJson(
              json.decode(utf8.decode(_response.bodyBytes)));
      DartNotificationCenter.post(channel: 'refreshHome');
      Get.toNamed(Routes.MARKETPLACE_PURCHASE_SUCCESS, arguments: {
        'product': product,
        'productDetail': productDetail,
        'response': response
      });
    }
  }
}
