import 'package:flutter/cupertino.dart';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;

class ValueCard extends StatelessWidget {
  const ValueCard({
    Key? key,
    required int number,
  })   : _number = number,
        super(key: key);

  final int _number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 15,
      decoration: BoxDecoration(
        color: themes.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Text(
          "+$_number",
          style: themes.textStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: themes.secondaryColor,
          ),
        ),
      ),
    );
  }
}
