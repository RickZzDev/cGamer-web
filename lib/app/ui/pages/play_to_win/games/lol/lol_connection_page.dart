import 'dart:io';

import 'package:cGamer/app/controllers/play_to_win/games/lol/lol_connection/lol_connection_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LolConnectionPage extends StatefulWidget {
  @override
  _LolConnectionPageState createState() => _LolConnectionPageState();
}

class _LolConnectionPageState extends State<LolConnectionPage> {
  final _controller = Get.put(LolConnectionController());

  var formState = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.formState = this.formState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          child: CustomAppBar(
            appBarTxt: 'Conecte sua conta',
          ),
          preferredSize: Size.fromHeight(60),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qual o nome do seu invocador?',
                  style: textStyle.copyWith(fontSize: 20),
                ),
                Text('Jogue e ganhe Rubis no app. ',
                    style: textStyle.copyWith(
                        fontSize: 15, color: Colors.white.withOpacity(0.7))),
                SizedBox(
                  height: 24,
                ),
                Form(
                  key: this.formState,
                  child: CustomTextField(
                    validation: _controller.nickIsValid,
                    labelText: 'Invocador',
                    controller: _controller.nickText,
                    autoFocus: false,
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 45, vertical: Platform.isAndroid ? 0 : 40),
          child: GenericButton(
            text: 'Avançar',
            txtColor: Colors.white,
            onPressedFunction: _controller.toAccountValidationPage,
          ),
        ));
  }
}
