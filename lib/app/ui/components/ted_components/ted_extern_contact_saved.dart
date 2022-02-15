import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactSavedExternRow extends StatelessWidget {
  final String? letters;
  final String? name;
  final String? bankName;
  final List<dynamic>? accounts;
  final Animation<double>? animation;
  const ContactSavedExternRow(
      {Key? key,
      this.letters,
      this.bankName,
      this.name,
      this.accounts,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primaryColor,
          child: Text(
            GenericUtils.getInitialsName(name),
            style: textStyle,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          width: screenWidthhSize * 0.75,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name ?? "",
                style: textStyle,
              ),
              RotationTransition(
                turns: animation!,
                child: Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
