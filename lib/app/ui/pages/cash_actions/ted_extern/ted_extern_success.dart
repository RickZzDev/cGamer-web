import 'package:cGamer/app/controllers/cash_actions_controllers/cash_ted/ted_extern_success.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/cash_in_components/verify_info_row.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/add_contact_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SuccessTransferExtern extends StatelessWidget {
  final TransferExternSuccessController _controller =
      Get.find<TransferExternSuccessController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.inAssyncCall.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: utils.primaryColor,
        ),
        child: Scaffold(
          backgroundColor: utils.primaryColor,
          body: Column(
            children: [
              Container(
                height: utils.screenHeigthSize * 0.4,
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Transferência",
                      style: utils.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "realizada!",
                      style: utils.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 150,
                      child: SvgPicture.asset(
                          "assets/images/deposit_way_icons/transfer_check.svg"),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: utils.secondaryColor,
                    borderRadius: utils.radiusTop15,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      VerifyInfoRow(
                        infoName: "Valor",
                        info: _controller.infoModel.ammount,
                        color: Colors.white,
                        bottomBorder: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VerifyInfoRow(
                        infoName: "Salvar contato",
                        info: "",
                        bottomBorder: true,
                        color: Colors.white,
                        widgetAction: Obx(
                          () => AddContactsButton(
                            onTap: () => _controller.contactSaved.value
                                ? null
                                : _controller.saveContact(),
                            enabled: true,
                            completed: _controller.contactSaved.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VerifyInfoRow(
                        infoName: "Para",
                        info: _controller.infoModel.fullName,
                        bottomBorder: true,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VerifyInfoRow(
                        infoName: "Data do envio",
                        info: _controller.infoModel.transferDate,
                        color: Colors.white,
                        bottomBorder: true,
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: GenericButton(
                          text: "Ver comprovante",
                          txtColor: Colors.white,
                          onPressedFunction: () => Get.toNamed(
                            Routes.TRANSFER_RECEIPT,
                            arguments: {
                              "type": _controller.type,
                              "value": _controller.value,
                              "ted_info": _controller.infoModel,
                              'ted_transfer_response':
                                  _controller.responseTransfer
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: GenericButton(
                          text: "Voltar ao inicio",
                          color: Colors.grey[400],
                          onPressedFunction: () =>
                              Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                          txtColor: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
