import 'package:cGamer/app/controllers/wallet_controllers/card_extract_controllers/card_extract_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/wallet_components/card_extract_components/choice_menu/choice_menu.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';

class CardExtractPage extends StatelessWidget {
  final CardExtractController _controller = Get.find<CardExtractController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Text(
            'Movimentações',
            style: textStyle,
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ChoiceMenu(_controller),
              CardTransactionsList(_controller)
            ],
          ),
        ),
      ),
    );
  }
}
