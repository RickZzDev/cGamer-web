import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizationUserName extends StatelessWidget {
  CustomizationUserName({required this.controller});
  final CustomizationController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "@",
          style: TextStyle(color: Colors.grey[500], fontSize: 22),
        ),
        Obx(() => Text(
              controller.model.value.customerUsername ?? "nomedousuario",
              style: TextStyle(
                  fontSize: 26,
                  color: controller.nickColor?.value ?? Colors.white),
            ))
      ],
    );
  }
}
