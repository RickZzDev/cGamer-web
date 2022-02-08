import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/ui/pages/account_activation/account_activation_page.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserRegisterStatus extends StatelessWidget {
  final BankController controller;

  UserRegisterStatus({required this.controller});

  @override
  Widget build(BuildContext context) {
    final registerModel = controller.statusRegisterResult.value;

    return GestureDetector(
      onTap: () => Get.to(() => AccountActivationPage(
            controller: controller,
          )),
      child: Container(
        margin: EdgeInsets.only(top: 0),
        padding: EdgeInsets.all(10),
        width: screenWidthhSize,
        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffEA4FF9), Color(0xff5869EB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70,
              width: 70,
              child: Image.asset(
                registerModel.statusBanlky == null
                    ? 'assets/images/account_activation_icons/IconBanner01.png'
                    : registerModel.statusBanlky == 'REPROVED'
                        ? 'assets/images/account_activation_icons/IconBanner03.png'
                        : 'assets/images/account_activation_icons/IconBanner02.png',
                width: 80,
                height: 80,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //, PENDING_APPROVAL, REPROVED;
                Text(
                  registerModel.statusBanlky == null
                      ? 'Ative sua conta'
                      : registerModel.statusBanlky == 'PENDING_APPROVAL'
                          ? 'Em análise'
                          : 'Não aprovado',
                  style: textStyle,
                  textAlign: TextAlign.start,
                ),
                Text(
                  registerModel.statusBanlky == null
                      ? 'Para utilizar os serviços financeiros, complete\nseus dados e envie seus documentos.'
                      : registerModel.statusBanlky == 'PENDING_APPROVAL'
                          ? 'Em até 10 minutos você terá o resultado\nde sua análise, aproveite e jogue uma partida :)'
                          : 'Acesse para ver mais detalhes da sua análise.',
                  style: textStyle.copyWith(fontSize: 12),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
