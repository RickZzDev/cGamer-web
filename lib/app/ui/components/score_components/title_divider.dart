import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

// ignore: must_be_immutable
class TitleDivider extends StatelessWidget {
  String title;
  EdgeInsets? edgeInsets;
  TitleDivider(
      {required this.title,
      this.actionTitle = "",
      this.onTap,
      this.edgeInsets});
  String? actionTitle;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: edgeInsets ??
                EdgeInsets.only(
                  left: 16,
                  bottom: 12,
                  right: 16,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(title,
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                      ),
                      actionTitle != ""
                          ? GestureDetector(
                              onTap: onTap,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(actionTitle ?? "",
                                      style: textStyle.copyWith(
                                          color: Colors.white70))))
                          : Container()
                    ]),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[500]!))),
                )
              ],
            )));
  }
}
