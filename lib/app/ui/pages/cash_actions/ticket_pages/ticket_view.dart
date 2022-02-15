import 'package:cGamer/app/controllers/cash_actions_controllers//ticket_view_controller/ticket_view_controller.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/cash_in_components/deposit_hint.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/pages/cash_actions/ticket_pages/ticket_nav_card.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TicketView extends StatelessWidget {
  final TicketViewController _controller = Get.find<TicketViewController>();

  @override
  Widget build(BuildContext _context) {
    _controller.payd = Get.arguments != null ? Get.arguments["payd"] : false;

    if (Get.arguments != null && Get.arguments["status"] == "boleto_gerado") {
      _controller.ticketInfo =
          Get.arguments != null ? Get.arguments["ticket_info"] : null;
      _controller.totalToPay.updateValue(Get.arguments["value_to_pay"]);
      _controller.barCodeController.text = _controller.ticketInfo.barCode;
    } else if (Get.arguments != null) {
      _controller.singleTicket =
          Get.arguments != null ? Get.arguments["ticket_info"] : null;
      _controller.totalToPay
          .updateValue(_controller.singleTicket.amount.toDouble());
      _controller.barCodeController.text = _controller.singleTicket.barCode;
    }
    _controller.status =
        Get.arguments != null ? Get.arguments["status"] : _controller.status;

    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: themes.primaryColor,
        ),
        child: Scaffold(
          backgroundColor: themes.secondaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: "Depósito",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _controller.status == "boleto_pago"
                          ? "Boleto pago com sucesso"
                          : _controller.status == "boleto_gerado"
                              ? "Boleto gerado com sucesso"
                              : "Aguardando pagamento",
                      style: themes.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: _controller.payd
                              ? themes.primaryColor
                              : Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      _controller.status == "boleto_pago"
                          ? "Pago em ${_controller.singleTicket.payment?.paidOutDate} "
                          : _controller.status == "boleto_gerado"
                              ? "Vencimento para o dia ${_controller.ticketInfo.dueDate}"
                              : "Vencimento para o dia ${_controller.singleTicket.dueDate}",
                      style: themes.textStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _controller.status == "boleto_pago"
                        ? Container()
                        : Text(
                            "Este boleto não pode ser pago parcialmente ou após o vencimento.",
                            textAlign: TextAlign.center,
                            style: themes.textStyle.copyWith(fontSize: 15),
                          ),
                    SizedBox(
                      height: 16,
                    ),
                    _controller.status == "boleto_pago"
                        ? SizedBox()
                        : Text(
                            "Utilize o código abaixo para fazer o pagamento e receber o valor na sua conta do Jogga Bank",
                            textAlign: TextAlign.center,
                            style: themes.textStyle.copyWith(
                                color: themes.primaryColor, fontSize: 16),
                          ),
                    SizedBox(
                      height: _controller.status == "boleto_pago" ? 0 : 24,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            child: Text(
                              _controller.status == "boleto_pago"
                                  ? "${_controller.singleTicket.payment?.id}"
                                  : _controller.barCodeController.text,
                              textAlign: TextAlign.center,
                              style: themes.textStyle.copyWith(
                                color: themes.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: _controller.status == "boleto_pago" ? 0 : 24,
                    ),
                    _controller.status == "boleto_pago"
                        ? SizedBox()
                        : GenericButton(
                            text: "Copiar código",
                            txtColor: Colors.white,
                            onPressedFunction: () => FlutterClipboard.copy(
                                    '${_controller.ticketInfo.barCode}')
                                .then(
                              (value) => Get.rawSnackbar(
                                message: "Código do boleto copiado com sucesso",
                                backgroundColor: themes.primaryColor,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 16,
                    ),
                    _controller.status == "boleto_pago"
                        ? SizedBox()
                        : GenericButton(
                            text: "Visualizar boleto",
                            onPressedFunction: () =>
                                _controller.createFileOfPdfUrl(),
                            txtColor: Colors.white,
                          ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      _controller.status == "boleto_pago"
                          ? "Valor pago"
                          : "Valor a pagar",
                      style: themes.textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      _controller.totalToPay.text,
                      style: themes.textStyle.copyWith(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _controller.status == "boleto_pago"
                        ? Container()
                        : DepositHint(),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TicketNavCard(
                          imgName: "Inicio",
                          label: "Inicio",
                          onTap: () =>
                              Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        TicketNavCard(
                          imgName: "Extrato",
                          label: "Extrato",
                          onTap: () =>
                              Get.offAllNamed(Routes.MAIN_PAGES_HOLDER),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
