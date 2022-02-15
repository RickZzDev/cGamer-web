import 'package:cGamer/app/controllers/extract/extract_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExtractPage extends StatelessWidget {
  final ExtractController _controller = Get.find<ExtractController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      home: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            backgroundColor: secondaryColor,
            title: Text('Movimentações'),
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
            child: Column(
              children: [
                ChooseMenu(_controller),
                TransactionsList(_controller)
              ],
            ),
          )),
    );
  }
}
