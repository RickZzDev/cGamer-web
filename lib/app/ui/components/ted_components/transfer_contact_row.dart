import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactRowTransfer extends StatelessWidget {
  final String? ammount;
  final String? letters;
  final String? fullName;
  final Function onClick;
  final String? userName;
  ContactRowTransfer({
    Key? key,
    required this.ammount,
    required this.letters,
    required this.fullName,
    required this.onClick,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(userName),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: utils.primaryColor,
            child: Text(
              letters ?? "",
              style: utils.textStyle,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            width: utils.screenWidthhSize * 0.75,
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
                Flexible(
                  child: Text(
                    fullName ?? "",
                    style: utils.textStyle,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
