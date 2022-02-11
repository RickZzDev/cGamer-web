import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardAddedSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Cartão adicionado com sucesso",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Agora você já pode utilizá-lo para fazer compra em nossa Gamer Store",
              style: textStyle.copyWith(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: screenWidthhSize,
              height: 250,
              color: Colors.grey,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              width: 180,
              child: GenericButton(
                onPressedFunction: () => Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                text: "Ir pra carteira",
                txtColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
