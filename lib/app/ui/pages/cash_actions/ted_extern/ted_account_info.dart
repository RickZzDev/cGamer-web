import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_account_info_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TedAccountInfo extends StatefulWidget {
  @override
  _TedAccountInfoState createState() => _TedAccountInfoState();
}

class _TedAccountInfoState extends State<TedAccountInfo> {
  final TedAccountInfoController _controller =
      Get.find<TedAccountInfoController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

      }, child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Transferir",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              normalText: "Digite abaixo a",
              customText: "agência e conta",
              normalText2: "de (nome completo)",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 32,
            ),
            CustomRichText(
              normalText: "(sem dígito)",
              customText: "Agência",
              customFirst: true,
            ),
            CustomTextField(
              labelText: "",
              type: TextInputType.number,
              controller: _controller.agencyController,
            ),
            SizedBox(
              height: 24,
            ),
            CustomRichText(
              normalText: "(com dígito)",
              customText: "Conta",
              customFirst: true,
            ),
            CustomTextField(
              labelText: "",
              type: TextInputType.number,
              controller: _controller.accountNumberController,
            ),
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GenericButton(
                    text: "Avançar",
                    haveToReturnContext: false,
                    onPressedFunction: () => _controller.changePage(),
                    txtColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
