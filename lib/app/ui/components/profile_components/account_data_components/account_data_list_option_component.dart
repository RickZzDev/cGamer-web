import 'package:cGamer/app/controllers/profile/account_data/account_data_list_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDataListOption extends StatelessWidget {
  final AccountDataListController controller;

  final IconData icon;
  final String title;
  final String subtitle;
  final Function onTap;
  const AccountDataListOption({
    Key? key,
    required this.controller,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 8),
            width: themes.screenWidthhSize - 48,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: themes.textStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subtitle,
                            style: themes.textStyle.copyWith(
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    icon,
                    color: Colors.white70,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
