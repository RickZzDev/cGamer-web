import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class AccountTypeRow extends StatelessWidget {
  final String txt;
  AccountTypeRow({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style: utils.textStyle,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
