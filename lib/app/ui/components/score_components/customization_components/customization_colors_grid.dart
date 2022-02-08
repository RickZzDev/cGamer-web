import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/data/models/score_models/customization/color_customization_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class CustomizationColorsGrid extends StatelessWidget {
  CustomizationColorsGrid({required this.controller, required this.model});
  final CustomizationController controller;
  final ColorCustomizationModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomizationUserName(
              controller: controller,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GridView.builder(
                    itemCount: model.colors?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: screenWidthhSize * 0.10,
                        mainAxisSpacing: 20,
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return CustomizationColorItem(
                        color: model.colors?[index],
                        controller: controller,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
