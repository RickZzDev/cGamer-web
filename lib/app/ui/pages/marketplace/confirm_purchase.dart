import 'dart:convert';
import 'dart:io';

import 'package:cGamer/app/controllers/marketplace/product_confirm_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/marketplace/subcategory_items.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class MarketplaceConfirmBuy extends StatelessWidget {
  final ProductConfirmController _controller =
      Get.find<ProductConfirmController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: screenHeigthSize * 0.18,
            flexibleSpace: Padding(
                padding: EdgeInsets.only(
                  top: screenHeigthSize * 0.02,
                ),
                child: SizedBox(
                    width: screenWidthhSize,
                    child: _controller.productDetail?.image != null &&
                            _controller.productDetail!.image!.contains('http')
                        ? CachedNetworkImage(
                            imageUrl: _controller.productDetail?.image ?? "",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: utils.primaryColor,
                                ),
                            width: screenWidthhSize,
                            cacheKey: _controller.productDetail?.image ?? "",
                            useOldImageOnUrlChange: true,
                            fit: BoxFit.fitWidth)
                        : Image.memory(base64Decode(_controller
                            .productDetail!.image!
                            .replaceAll("data:image/png;base64,", ""))))),
            floating: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: Platform.isIOS
                    ? screenHeigthSize * 0.70
                    : screenHeigthSize * 0.75,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenHeigthSize * 0.03, left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Platform.isIOS
                            ? screenHeigthSize * 0.60
                            : screenHeigthSize * 0.65,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _controller.productDetail?.description != null
                                  ? Text(
                                      _controller.productDetail?.description ??
                                          "",
                                      style: textStyle,
                                    )
                                  : Container(),
                              SizedBox(
                                height: screenHeigthSize * 0.005,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Método de pagamento",
                                    style: textStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    hint: Text(
                                      "Saldo em conta",
                                      style: textStyle.copyWith(fontSize: 14),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          "Saldo em conta",
                                          style:
                                              textStyle.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                    dropdownColor: secondaryColor,
                                    onChanged: (String? value) {},
                                  )
                                ],
                              ),
                              Text(
                                "Saldo disponível",
                                style: textStyle,
                              ),
                              Obx(
                                () => _controller
                                        .hasCompletedBalanceRequest.value
                                    ? Text(
                                        "${_controller.balanceModel.balanceAvailable?.available}",
                                        textAlign: TextAlign.start,
                                        style: textStyle.copyWith(
                                            fontWeight: FontWeight.bold))
                                    : Shimmer.fromColors(
                                        baseColor: utils.secondaryColor,
                                        highlightColor: Colors.blueGrey[400],
                                        child: Container(
                                          width: 180,
                                          height: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Obx(() => Container(
                                    child: SubcategoryItem(
                                      titleFontSize: 15,
                                      product: _controller.product,
                                      isPrime: _controller.isPrime.value,
                                    ),
                                  )),
                              SizedBox(
                                height: 16,
                              ),
                              Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _controller.productDetail
                                              ?.termsAndConditions !=
                                          null
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes
                                                    .MARKETPLACE_CONFIRM_TERMS_USE,
                                                arguments: {
                                                  "terms_use": _controller
                                                      .productDetail
                                                      ?.termsAndConditions
                                                });
                                          },
                                          child: Text(
                                            'Termos e condições',
                                            style: textStyle.copyWith(
                                                fontSize: 16,
                                                color: Colors.white70,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                      GenericButton(
                        text: "Comprar",
                        onPressedFunction: () => _controller.hasBalanceToBuy()
                            ? Get.toNamed(Routes.MARKETPLACE_PASSSWORD_CONFIRM,
                                arguments: {
                                    'product': _controller.product,
                                    'productDetail': _controller.productDetail
                                  })
                            : SnackBarUtils.showSnackBar(
                                desc:
                                    "Você não tem saldo suficiente, recarregue para tentar novamente.",
                                title: "Atenção"),
                        color: primaryColor,
                        txtColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
