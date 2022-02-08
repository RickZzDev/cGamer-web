import 'package:cGamer/app/controllers/cash_actions_controllers/payments_controllers/write_bar_code_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WritebarCodePage extends StatefulWidget {
  @override
  _WritebarCodePageState createState() => _WritebarCodePageState();
}

class _WritebarCodePageState extends State<WritebarCodePage> {
  final WriteBarCodeController _controller = Get.find<WriteBarCodeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.inAssyncCall.value,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: primaryColor,
          ),
          child: Scaffold(
              backgroundColor: secondaryColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: CustomAppBar(
                  appBarTxt: "Pagar contas",
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      textAlign: TextAlign.start,
                      normalText: 'Digite os números do',
                      customText: 'código de barras',
                    ),
                    CustomTextField(
                      controller: _controller.textController,
                      labelText: '',
                      type: TextInputType.number,
                      autoFocus: true,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            GenericButton(
                              text: "Avançar",
                              onPressedFunction: () => _controller.validateField()
                                  ? _controller.validateBarCode()
                                  : SnackBarUtils.showSnackBar(
                                      desc:
                                          "Preencha corretamente o código de barras.",
                                      title: "Atenção",
                                      color: Colors.orange[400]!),
                              color: primaryColor,
                              txtColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
