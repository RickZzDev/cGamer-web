import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/data/models/score_models/customization/color_customization_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class CustomizationHeader extends StatelessWidget {
  CustomizationHeader({required this.controller, required this.model});

  final ColorCustomizationModel model;
  final CustomizationController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/gamification_icons/cristal.png',
          height: 20,
          width: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          "${model.customerBalancePoints.formattedPoints()} Rubis",
          style: textStyle.copyWith(
            color: primaryColor,
            fontSize: 22,
          ),
        )
      ],
    );
  }
}
