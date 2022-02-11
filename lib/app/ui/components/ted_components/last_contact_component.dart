import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class ContactComponent extends StatelessWidget {
  final Function onClick;
  final String? userName;
  final String? name;

  ContactComponent({
    Key? key,
    required this.onClick,
    required this.userName,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(userName),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: utils.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            width: 50,
            height: 50,
            child: Center(
              child: Text(
                GenericUtils.getInitialsName(name),
                style: utils.textStyle.copyWith(fontSize: 14),
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
                style: utils.textStyle.copyWith(fontSize: 14),
              ),
              Text(
                userName ?? "",
                style: utils.textStyle.copyWith(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
