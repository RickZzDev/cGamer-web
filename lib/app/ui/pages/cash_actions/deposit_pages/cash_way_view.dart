import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/controllers/cash_actions_controllers/cash_in_types/cash_in_types.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/cash_in_components/cash_in_option.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class CashInTypesView extends StatelessWidget {
  final CashInTypeController _controller = Get.find<CashInTypeController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    _controller.type == null
        ? _controller.type = Get.arguments["type"]
        : DoNothingAction();
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt:
              _controller.type == "deposit" ? "Depósito" : "Transferência",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRichText(
                textAlign: TextAlign.start,
                normalText: "Como você",
                customText: _controller.type == "deposit"
                    ? "prefere depositar?"
                    : "prefere transferir?",
              ),
              SizedBox(
                height: 8,
              ),
              CustomRichText(
                normalText: _controller.type == "deposit"
                    ? "Deposite na sua conta por Boleto, TED ou PIX. \nEscolha abaixo a"
                    : " Faça uma transferência interna ou uma retirada de dinheiro. \nEscolha abaixo a",
                customText: _controller.type == "deposit"
                    ? "melhor opção para você"
                    : "melhor opção para você",
                color: Colors.white70,
                fontSize: 14,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CahsInOption(
                    onTap: _controller.type == 'deposit'
                        ? () => _controller.changeIconDirection()
                        : () => _controller.goToChooseValue(),
                    controller: _controller,
                    imgPath: _controller.type == 'deposit' ? "barcode" : "p2p",
                    icon: _controller.type == 'deposit'
                        ? Icons.keyboard_arrow_down_sharp
                        : Icons.arrow_forward_ios,
                    animateIcon: _controller.type == 'deposit' ? true : false,
                    title: _controller.type == 'deposit'
                        ? "Boleto Bancario"
                        : "Transferir para um gamer",
                    subtitle: _controller.type == 'deposit'
                        ? "Saldo liberado em até 3 dias úteis"
                        : "Imediato e sem tarifa.",
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: _controller.showDropDown ? 100 : 0,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(
                                Routes.CHOOSE_DEPOSIT_VALUE,
                                arguments: {
                                  "tax": _controller.tax.tax,
                                  'type': 'deposit'
                                },
                              ),
                              child: AnimatedOpacity(
                                opacity: _controller.showDropDown ? 1 : 0,
                                duration: Duration(milliseconds: 100),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                          begin: Offset(-0, -0.7),
                                          end: Offset.zero)
                                      .animate(_controller.animationController!),
                                  child: Container(
                                    width: screenWidthhSize * 0.7,
                                    margin: EdgeInsets.only(bottom: 8),
                                    key: UniqueKey(),
                                    padding: EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2, color: Colors.white),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Novo boleto",
                                              style: textStyle.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white70,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(Routes.TICKET_LIST_VIEW),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(-0, 0.5),
                                        end: Offset.zero)
                                    .animate(_controller.animationController!),
                                child: AnimatedOpacity(
                                  opacity: _controller.showDropDown ? 1 : 0,
                                  duration: Duration(milliseconds: 100),
                                  child: Container(
                                    width: screenWidthhSize * 0.7,
                                    key: UniqueKey(),
                                    padding: EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 2, color: Colors.white),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.visibility,
                                              color: primaryColor,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "Ver boletos",
                                              style: textStyle.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CahsInOption(
                    onTap: () => _controller.type == 'deposit'
                        ? Get.toNamed(Routes.DEPOSIT_TED)
                        : Get.toNamed(Routes.CHOOSE_DEPOSIT_VALUE, arguments: {
                            "type": "transfer_extern",
                            'tax': _controller.tedTax.tax
                          }),
                    controller: _controller,
                    imgPath: "transfer",
                    icon: Icons.arrow_forward_ios,
                    title: _controller.type == 'deposit'
                        ? "Transferência (TED/PIX)"
                        : "Retirada de dinheiro",
                    subtitle: _controller.type == 'deposit'
                        ? "Sem custos e liberado em até 2h"
                        : "Saldo liberado de 1h até 1 dia útil",
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CahsInOption(
                    onTap: () {},
                    controller: _controller,
                    imgPath: "pix",
                    icon: null,
                    title: "Pix",
                    subtitle: "Em breve",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
