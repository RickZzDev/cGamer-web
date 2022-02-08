import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactExternRow extends StatelessWidget {
  final String? letters;
  final String? name;
  final String? bankName;
  const ContactExternRow({Key? key, this.letters, this.bankName, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              GenericUtils.getInitialsName(name),
              style: textStyle.copyWith(fontSize: 14),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name ?? "",
              style: textStyle.copyWith(fontSize: 14),
            ),
            Text(
              bankName ?? "",
              style: textStyle.copyWith(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
