import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;

class MessageField extends StatelessWidget {
  const MessageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(right: 24, left: 24),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Escreva uma mensagem (opcional)",
          contentPadding: const EdgeInsets.only(
            left: 36.0,
            bottom: 16.0,
            // top: 8.0,
          ),
          hintStyle: utils.textStyle.copyWith(
            color: utils.secondaryColor,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white),
            borderRadius: new BorderRadius.circular(10),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.white),
            borderRadius: new BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
