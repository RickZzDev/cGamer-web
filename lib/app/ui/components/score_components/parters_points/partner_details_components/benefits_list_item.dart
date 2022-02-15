import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class BenefitsListItem extends StatelessWidget {
  final String benefit;

  BenefitsListItem(this.benefit);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          width: 6,
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(benefit,
              style: textStyle.copyWith(
                fontSize: 15,
              )),
        )
      ],
    );
  }
}
