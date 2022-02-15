import 'dart:convert';

import 'package:cGamer/app/controllers/cash_actions_controllers/receipt_controller/receipt_controller.dart';
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ReceiptPage extends StatefulWidget {
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final ReceiptController _controller = Get.find<ReceiptController>();
  String? value;
  TedInfoModel _tedInfoModel = TedInfoModel();
  TransferResponseModel _transferResponseModel = TransferResponseModel();

  @override
  void initState() {
    value = Get.arguments["value"];
    _tedInfoModel =
        Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
    _transferResponseModel = Get.arguments["ted_transfer_response"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utils.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Comprovante",
        ),
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: _controller.screenshotController,
          child: Container(
            decoration: BoxDecoration(
              color: utils.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 150,
                      margin: EdgeInsets.only(left: 32, top: 32),
                      child: Image.asset('assets/images/logo/logo_gray.png'),
                    ),
                    Obx(() {
                      return Opacity(
                        opacity: _controller.iconOnScreen.value ? 1 : 0,
                        child: IconButton(
                          onPressed: () => _controller.captureScreenshot(),
                          icon: Icon(Icons.ios_share),
                          color: utils.secondaryColor,
                          iconSize: 24,
                        ),
                      );
                    })
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FromUserData(
                    fromCustomer: _transferResponseModel.fromCustomer,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValueToTransfer(
                    value: value ?? "",
                    name: _tedInfoModel.fullName != null
                        ? utf8.decode(_tedInfoModel.fullName!.codeUnits)
                        : "",
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ToUserData(
                    toCustomer: _transferResponseModel.toCustomer,
                    bank: _tedInfoModel.bank,
                    method: _tedInfoModel.method,
                    account: _tedInfoModel.accountNumber,
                    agency: _tedInfoModel.agency,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: utils.secondaryColor,
                  height: 100,
                  width: utils.screenWidthhSize,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      Container(
                        width: utils.screenWidthhSize,
                        height: 25,
                        child: SvgPicture.asset(
                          "assets/images/picotado.svg",
                          color: utils.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Text("Autenticação:",
                          style: utils.textStyle
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(_transferResponseModel.authenticationCode ?? "",
                          style: utils.textStyle)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
