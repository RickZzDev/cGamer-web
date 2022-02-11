import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final double textSize;
  DescriptionField({this.textEditingController, this.textSize = 16});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: this.textEditingController,
          style: textStyle.copyWith(fontSize: this.textSize),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.transparent,
            )),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ));
  }
}
