import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/at_to_transfer_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AtToTransfer extends StatelessWidget {
  final AtToTRansferController _controller = Get.find<AtToTRansferController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.inAssyncCall.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: utils.primaryColor,
        ),
        child: Scaffold(
          backgroundColor: utils.secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Transferir",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CustomRichText(
                  textAlign: TextAlign.start,
                  normalText: "",
                  customText:
                      "Digite abaixo o @ do usuário que você deseja transferir",
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  labelText: "@",
                  controller: _controller.textController,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 24, left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GenericButton(
                          text: "Avançar",
                          haveToReturnContext: false,
                          onPressedFunction: () => _controller.searchUser(),
                          txtColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
