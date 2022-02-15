import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class ActionsCardComponent extends StatelessWidget {
  String status;
  ActionsCardComponent({required this.status});
  @override
  Widget build(BuildContext context) {
    List<ActionCard> cardList = [
      ActionCard(
        length: 0,
        isApproved: status == 'APPROVED' ? true : false,
        principalTxt: 'Depositar',
        imgName: 'Depositar',
        onTap: () => Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY,
            arguments: {"type": "deposit"}),
      ),
      ActionCard(
          length: 1,
          isApproved: status == 'APPROVED' ? true : false,
          principalTxt: 'Transferir',
          imgName: 'Transferir',
          onTap: () => Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY,
              arguments: {"type": "transfer"})),
      ActionCard(
        length: 2,
        isApproved: status == 'APPROVED' ? true : false,
        principalTxt: 'Recarga',
        imgName: 'Recarga_de_celular',
        onTap: () => Get.toNamed(Routes.RECHARGE_PHONE_NUMBER),
      ),
      ActionCard(
        length: 3,
        isApproved: status == 'APPROVED' ? true : false,
        customizedSize: 25,
        principalTxt: 'Pagar',
        imgName: 'Pagar_contas',
        onTap: () => Get.toNamed(Routes.PAYMENT_READ_BAR_CODE),
      ),
      ActionCard(
          length: 4,
          isApproved: status == 'APPROVED' ? false : false,
          principalTxt: 'Pix',
          imgName: 'pix',
          onTap: () => {}),
    ];

    return Container(
      height: 85,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return cardList[index];
        },
        itemCount: cardList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
