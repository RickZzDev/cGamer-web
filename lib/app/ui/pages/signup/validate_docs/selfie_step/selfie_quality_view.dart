import 'dart:io';

import 'package:cGamer/app/controllers/signup/validate_docs/selfie_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as style;

import 'package:cGamer/app/ui/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../components/components.dart';

class SelfieQualityView extends StatefulWidget {
  SelfieQualityView(this.selfieController) : assert(selfieController != null);

  final SelfieController selfieController;

  @override
  _SelfieQualityViewState createState() => _SelfieQualityViewState();
}

class _SelfieQualityViewState extends State<SelfieQualityView> {
  // SelfieController _controller = Get.put(SelfieController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Verifique a foto",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: style.screenHeigthSize * 0.60,
              width: style.screenWidthhSize,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Image.file(
                  widget.selfieController.file.value ?? File(''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: style.screenWidthhSize / 2 - 48,
                    child: GenericButton(
                      height: 48,
                      color: style.secondaryColor,
                      icon: Icons.camera_alt_rounded,
                      txtColor: Colors.white,
                      text: 'Tirar outra',
                      onPressedFunction: () {
                        widget.selfieController.getImage();
                        // widget.selfieController.setLoading();
                      },
                    ),
                  ),
                  Container(
                    width: style.screenWidthhSize / 2 - 48,
                    child: GenericButton(
                      icon: Icons.check_circle,
                      txtColor: Colors.white,
                      text: 'Ficou boa',
                      onPressedFunction: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
