import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/controllers/profile/security/security_controller.dart';
import 'package:get/get.dart';

class FaceIdCellComponent extends StatelessWidget {
  final SecurityController controller;

  FaceIdCellComponent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Para proteger sua conta',
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Biometria ou FaceID',
                  style: textStyle.copyWith(fontSize: 14),
                )
              ],
            ),
            Obx(() => Switch(
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: controller.onChangedSwitch,
                  value: controller.switchValue.value,
                ))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          height: 2,
        ),
      ]),
    );
  }
}
