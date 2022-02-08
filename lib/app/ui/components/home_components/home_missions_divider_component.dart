import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMissionsDivider extends StatelessWidget {
  const HomeMissionsDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 12, right: 24),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.3,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Missões",
                style: textStyle.copyWith(
                    fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
