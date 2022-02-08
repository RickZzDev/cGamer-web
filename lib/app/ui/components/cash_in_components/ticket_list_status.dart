import 'package:cGamer/app/data/models/bankslip_models/ticket_list_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class TicketItem extends StatelessWidget {
  final Bankslips? ticketInfo;
  TicketItem({Key? key, required this.ticketInfo}) : super(key: key);

  final MoneyMaskedTextController moneyMask = MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: ',',
      leftSymbol: 'R\$ ',
      initialValue: 0.00);

  @override
  Widget build(BuildContext context) {
    moneyMask.updateValue(ticketInfo?.amount.toDouble());

    return Tooltip(
      message: ticketInfo?.status == "Settled"
          ? "Boleto pago"
          : "Aguardando pagamento",
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.black.withOpacity(0.5),
      ),
      textStyle: textStyle.copyWith(fontSize: 14),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.TICKET_VIEW, arguments: {
          "payd": ticketInfo?.status == "Settled" ? true : false,
          'ticket_info': ticketInfo,
          "status": ticketInfo?.status == "Settled" ? "boleto_pago" : ""
        }),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(1, 2.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    normalText: ticketInfo?.status == "Settled"
                        ? ticketInfo?.payment?.paidOutDate ?? ""
                        : ticketInfo?.dueDate ?? "",
                    customText: ticketInfo?.status == "Settled"
                        ? "Pago em"
                        : "Vencimento",
                    customFirst: true,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomRichText(
                    normalText: " ${moneyMask.text}",
                    customText: "Valor",
                    customFirst: true,
                    fontSize: 16,
                  )
                ],
              ),
              Icon(
                ticketInfo?.status == "Settled"
                    ? Icons.check_circle_outline
                    : Icons.timer,
                color: ticketInfo?.status == "Settled"
                    ? primaryColor
                    : Colors.yellow[400],
                size: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
