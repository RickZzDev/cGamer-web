import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketItemShimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                normalText: "xx/xx/xxx",
                customText: "Vencimento",
                customFirst: true,
                fontSize: 16,
              ),
              SizedBox(
                height: 8,
              ),
              CustomRichText(
                normalText: "R\$ 0,00",
                customText: "Valor",
                customFirst: true,
                fontSize: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}
