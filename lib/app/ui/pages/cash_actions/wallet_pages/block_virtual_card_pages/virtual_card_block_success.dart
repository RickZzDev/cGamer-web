import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/block_virtual_card/block_vitual_card_success_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VirtualCardBlockSuccessStep extends StatelessWidget {
  final VirtualCardBlockSuccessController _controller =
      Get.find<VirtualCardBlockSuccessController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                child: Text(
                  _controller.action == "lock"
                      ? "Seu cartão foi bloqueado com"
                      : _controller.action == "delete"
                          ? "Seu cartão foi excluído com"
                          : "Seu cartão foi desbloqueado com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Exo', fontSize: 24),
                ),
              ),
              Text(
                "SUCESSO",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    letterSpacing: 1,
                    fontFamily: 'Exo'),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                _controller.action == "lock"
                    ? "Seu cartão foi bloqueado, e não será mais possível utilizá-lo em transações."
                    : _controller.action == "delete"
                        ? "Seu cartão foi deletado, e não será mais possível utilizá-lo em transações."
                        : "Seu cartão foi desbloqueado, e já pode utilizá-lo em transações.",
                style: textStyle.copyWith(fontSize: 16, color: secondaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                      'assets/images/wallet_images/virtual_card_success.png')),
              SizedBox(
                height: 48,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: GenericButton(
                  haveToReturnContext: false,
                  text: "Ir para carteira",
                  onPressedFunction: () {
                    DartNotificationCenter.post(channel: 'refreshWallet');
                    Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
                  },
                  txtColor: Colors.white,
                  color: secondaryColor,
                ),
              )
            ],
          )),
    );
    // return Scaffold(
    //   backgroundColor: secondaryColor,
    //   resizeToAvoidBottomInset: false,
    //   body: Padding(
    //     padding: EdgeInsets.all(24),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: 48,
    //         ),
    //         Text(
    //           _controller.action == "lock"
    //               ? "Seu cartão foi bloqueado com sucesso."
    //               : _controller.action == "delete"
    //                   ? "Seu cartão foi excluído com sucesso."
    //                   : "Seu cartão foi desbloqueado com sucesso.",
    //           style: textStyle.copyWith(
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 16,
    //         ),
    //         Text(
    //           _controller.action == "lock"
    //               ? "Seu cartão foi bloqueado, e não será mais possível utilizá-lo em transações."
    //               : _controller.action == "delete"
    //                   ? "Seu cartão foi deletado, e não será mais possível utilizá-lo em transações."
    //                   : "Seu cartão foi desbloqueado, e já pode utilizá-lo em transações.",
    //           style: textStyle,
    //         ),
    //         SizedBox(
    //           height: 32,
    //         ),
    //         Container(
    //           child: Image.asset(
    //               'assets/images/wallet_images/virtual_card_success.png'),
    //           height: screenHeigthSize * 0.35,
    //         ),
    //         SizedBox(
    //           height: 24,
    //         ),
    //         Align(
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             _controller.action == "lock"
    //                 ? "Você pode desbloquear a qualquer momento"
    //                 : _controller.action == "delete"
    //                     ? "Você pode criar outro a qualquer momento"
    //                     : "Você pode bloquear a qualquer momento",
    //             style: textStyle.copyWith(),
    //             textAlign: TextAlign.start,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 8,
    //         ),
    //         Align(
    //             alignment: Alignment.topLeft,
    //             child: Text(
    //               _controller.action == "lock"
    //                   ? "Acesse sua carteira, caso precise desbloquear."
    //                   : _controller.action == "delete"
    //                       ? "Acesse sua carteira, caso queira criar outro."
    //                       : "Acesse sua carteira, caso precise bloquear novamente.",
    //               style: textStyle.copyWith(fontSize: 16),
    //             )),
    //         SizedBox(
    //           height: 16,
    //         ),
    //         BottomButton(
    //             txt: "Ir para carteira",
    //             onTap: () {
    //               DartNotificationCenter.post(channel: 'refreshWallet');
    //               Get.toNamed(Routes.MAIN_PAGES_HOLDER);
    //             }
    //             // color: Colors.white,
    //             ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
