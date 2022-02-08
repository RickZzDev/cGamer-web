import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsDropDown extends StatelessWidget {
  const AccountsDropDown(
      {Key? key,
      required this.contacts,
      required this.animationController,
      required this.showDropDown,
      required this.index})
      : super(key: key);

  final Rx<ContactsListModel> contacts;
  final AnimationController animationController;
  final int index;
  final bool showDropDown;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.value.allContacts?[index].accounts?.length ?? 0,
      separatorBuilder: (context, _index) => SizedBox(
        height: 5,
      ),
      itemBuilder: (context, _index) => SlideTransition(
        position: Tween<Offset>(begin: Offset(-0, 0.5), end: Offset.zero)
            .animate(animationController),
        child: AnimatedOpacity(
          opacity: showDropDown ? 1 : 0,
          duration: Duration(milliseconds: 100),
          child: Container(
            width: screenWidthhSize * 0.7,
            key: UniqueKey(),
            padding: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Banco: ",
                      style: textStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      contacts.value.allContacts?[index]
                              .accounts?[_index]["bank"]
                              .toString() ??
                          "",
                      style: textStyle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
