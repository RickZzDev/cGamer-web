import 'package:cGamer/app/controllers/marketplace/marketplace_success_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/marketplace/subcategory_items.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MarketPlaceSuccessPurchase extends StatelessWidget {
  final MarketPlaceSuccessController _controller =
      Get.find<MarketPlaceSuccessController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeigthSize * 0.45,
              color: primaryColor,
              margin: EdgeInsets.only(top: 16),
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      "GGWP! Compra realizada com sucesso.",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: screenHeigthSize * 0.16,
                    child: SvgPicture.asset(
                        "assets/images/deposit_way_icons/transfer_check.svg"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _controller.response?.transaction != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: GenericButton(
                            text: "Resgatar agora",
                            color: secondaryColor,
                            txtColor: Colors.white,
                            onPressedFunction: () {
                              GenericUtils.openUrl(
                                  _controller.response?.transaction?.url ?? "");
                            },
                          ))
                      : _controller.response?.pin != null
                          ? Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Seu código PIN',
                                    style: textStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _controller.response?.pin ?? "",
                                          style:
                                              textStyle.copyWith(fontSize: 22),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _controller.copyPin();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "PIN copiado com sucesso")));
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/profile_images/copy.svg',
                                            fit: BoxFit.contain,
                                            color: Colors.white,
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            )
                          : Container(
                              child: Text(
                                'Siga os passos abaixo para consumir seu produto.',
                                style: textStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                  SizedBox(
                    height: 8,
                  ),
                  _controller.productDetail?.howToRedeem != null
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.MARKETPLACE_CONFIRM_TERMS_USE,
                                arguments: {
                                  "how_to_redeem":
                                      _controller.productDetail?.howToRedeem
                                });
                          },
                          child: Text('Saiba como resgatar :)',
                              style: textStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                  decoration: TextDecoration.underline)))
                      : Container()
                ],
              ),
            ),
            Container(
              height: screenHeigthSize * 0.55,
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: screenHeigthSize * 0.1,
                          child: Obx(() => SubcategoryItem(
                                product: _controller.product,
                                isPrime: _controller.isPrime.value,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Método de pagamento",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          "Saldo em conta",
                          style: textStyle.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data da compra",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(DateTime.now()),
                          style: textStyle.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Autenticação/NSU",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          _controller.response?.transaction != null
                              ? _controller
                                      .response?.transaction?.transactionId ??
                                  ""
                              : _controller.response?.nsu != null
                                  ? _controller.response?.nsu ?? ""
                                  : _controller.response?.authorizationCode ??
                                      "",
                          style: textStyle.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: GenericButton(
                      text: "Voltar ao início",
                      color: Colors.white70,
                      txtColor: secondaryColor,
                      onPressedFunction: () =>
                          Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
