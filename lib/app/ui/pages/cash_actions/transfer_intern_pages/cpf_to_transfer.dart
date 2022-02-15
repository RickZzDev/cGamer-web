import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/cpt_to_transfer_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CpfTotransfer extends StatelessWidget {
  final CpfToTransferController _controller =
      Get.find<CpfToTransferController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
          inAsyncCall: _controller.inAssyncCall.value,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: utils.primaryColor,
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
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
                      normalText: "Digite abaixo o",
                      customText: "CPF do Gamer",
                      normalText2: "que",
                      customText2: "você deseja transferir",
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: _controller.formKey,
                      child: CustomTextField(
                        labelText: "CPF",
                        validation: Validations().validateCpf,
                        type: TextInputType.number,
                        controller: _controller.textController,
                        onChange: _controller.onCpfChange,
                        autoFocus: false,
                        validateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
