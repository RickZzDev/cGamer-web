import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ConnectionChat extends StatelessWidget {
  const ConnectionChat({Key? key}) : super(key: key);

  final String userName = "Fulano";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: AppBarWithResources()),
      body: Container(),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: secondaryColor,
        height: 80,
        child: TextField(
          style: textStyle.copyWith(fontSize: 14),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor)),
              hoverColor: primaryColor,
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: primaryColor,
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor))),
        ),
      ),
    );
  }
}
