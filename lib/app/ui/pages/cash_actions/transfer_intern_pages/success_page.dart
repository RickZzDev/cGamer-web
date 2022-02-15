import 'package:cGamer/app/controllers/cash_actions_controllers/transfer_intern_controllers/ted_intern_success_controller.dart';
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

class SuccessTransfer extends StatelessWidget {
  final TransferConfirmSuccessController _controller =
      Get.find<TransferConfirmSuccessController>();
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
                      _controller.type == "transfer" ||
                              _controller.type == "transfer_extern"
                          ? "Transferência"
                          : "Depósito",
                      style: utils.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      _controller.type == "transfer" ||
                              _controller.type == "transfer_extern"
                          ? "realizada!"
                          : "pago com sucesso!",
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
                      _controller.type == "transfer_extern"
                          ? VerifyInfoRow(
                              infoName: "Valor",
                              info: _controller.infoModel.ammount,
                              color: Colors.white,
                              bottomBorder: true,
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 8,
                      ),
                      VerifyInfoRow(
                        infoName: _controller.type == "transfer"
                            ? _controller.value
                            : _controller.type == "transfer_extern"
                                ? "Para"
                                : "Favorecido",
                        info: _controller.type == "transfer"
                            ? ""
                            : _controller.type == "transfer_extern"
                                ? _controller
                                    .responseTransfer.toCustomer?.customerName
                                : "Nome do favorecido",
                        widgetAction: _controller.type == "transfer"
                            ? Obx(
                                () => AddContactsButton(
                                  onTap: () => _controller.contactSaved.value
                                      ? null
                                      : _controller.saveContact(),
                                  enabled: true,
                                  completed: _controller.contactSaved.value,
                                ),
                              )
                            : null,
                        color: Colors.white,
                        bottomBorder: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VerifyInfoRow(
                        infoName: _controller.type == "transfer"
                            ? "Para"
                            : "Data do envio",
                        info: _controller.type == "transfer"
                            ? _controller.infoModel.fullName
                            : _controller.infoModel.transferDate,
                        color: Colors.white,
                        bottomBorder: true,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _controller.type == "transfer"
                          ? VerifyInfoRow(
                              info: _controller.infoModel.transferDate,
                              infoName: "Data de envio",
                              color: Colors.white,
                              bottomBorder: true,
                            )
                          : SizedBox(),
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
