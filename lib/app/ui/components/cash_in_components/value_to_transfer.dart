import 'package:flutter/cupertino.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class ValueToTransfer extends StatelessWidget {
  final String value;
  final String? name;
  ValueToTransfer({
    Key? key,
    required this.value,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Valor",
          style: utils.textStyle.copyWith(
            color: utils.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: utils.textStyle.copyWith(
              color: utils.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 32),
        ),
        Text(
          "para $name",
          style: utils.textStyle.copyWith(
            color: utils.secondaryColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
