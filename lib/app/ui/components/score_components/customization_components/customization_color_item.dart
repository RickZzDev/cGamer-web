import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:flutter/material.dart';

class CustomizationColorItem extends StatelessWidget {
  CustomizationColorItem({required this.color, required this.controller});
  final CustomizationController controller;
  final String? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.changeNickColor(color ?? ""),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: GenericUtils.getColorWithHex(color ?? ""),
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
