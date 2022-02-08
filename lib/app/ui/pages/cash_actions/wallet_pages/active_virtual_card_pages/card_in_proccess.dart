import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/bottom_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardInProccessStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
            ),
            Text(
              "Cartão virtual em processamento",
              style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Estamos processando seu cartão, em alguns minutos estará disponivel para uso",
              style: textStyle,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              child: Image.asset(
                  'assets/images/wallet_images/virtual_card_success.png'),
              height: screenHeigthSize * 0.35,
            ),
            SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Use na função Crédito",
                style: textStyle.copyWith(),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Faça compras online, assinaturas e muito mais com seu novo cartão!",
              style: textStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            BottomButton(
              txt: "Ir para carteira",
              onTap: () => Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
              // color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
