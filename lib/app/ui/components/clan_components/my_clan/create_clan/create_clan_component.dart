import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateClanComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomRichText(
              customFirst: true,
              textAlign: TextAlign.center,
              customText: "Você ainda não pertence a nenhum clã,",
              normalText: "procure um para fazer parte ou crie o seu!",
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                width: screenWidthhSize / 2,
                child: GenericButton(
                    color: Colors.white,
                    txtColor: secondaryColor,
                    text: 'Ver Ranking de Clãns',
                    onPressedFunction: () {
                      Get.toNamed(Routes.CLAN_RANKING);
                    }))
          ],
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: GenericButton(
                text: 'Criar um clã',
                txtColor: Colors.white,
                onPressedFunction: () => Get.toNamed(Routes.CREATE_NEW_CLAN)))
      ],
    ));
  }
}
