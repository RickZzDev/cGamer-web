import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/data/models/score_models/customization/color_customization_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class PurchaseArea extends StatelessWidget {
  PurchaseArea({required this.controller, required this.model});
  final CustomizationController controller;
  final ColorCustomizationModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: BoxDecoration(
          //color: Colors.red,
          image: DecorationImage(
              image: Image.asset(
        'assets/images/gamification_icons/color_customization_background.png',
        fit: BoxFit.cover,
        width: screenWidthhSize,
      ).image)),
      margin: EdgeInsets.only(bottom: screenHeigthSize * 0.03),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 24, right: 24),
              height: 40,
              child: CustomizationHeader(
                model: model,
                controller: controller,
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.red,
                padding: EdgeInsets.only(right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, bottom: 0, top: 20),
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: CustomRichText(
                                fontSize: 14,
                                textAlign: TextAlign.center,
                                customFirst: true,
                                customText: 'Teste as cores',
                                normalText: 'no seu @',
                                customText2: 'e utilize seu saldo',
                                normalText2: 'para comprar',
                                customText3: 'uma cor',
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            CustomizationColorsGrid(
                              controller: controller,
                              model: model,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
