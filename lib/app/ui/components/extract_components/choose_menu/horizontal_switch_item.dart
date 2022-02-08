import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalSwitchItem extends StatelessWidget {
  final String title;
  final int itemIndex;
  final ExtractController _controller;
  final Function onTap;

  HorizontalSwitchItem(
      this.title, this.itemIndex, this._controller, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          _controller.atualChooseItem.value = itemIndex;
          onTap();
        },
        child: Obx(() => Container(
              decoration: itemIndex == _controller.atualChooseItem.value
                  ? BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8))
                  : null,
              padding: EdgeInsets.all(5),
              child: Text(
                title,
                style: textStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
