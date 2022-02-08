import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeServicesGrid extends StatelessWidget {
  HomeServicesGrid({required this.isApproved});
  final bool isApproved;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            primary: true,
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: ((screenWidthhSize - 50) / 122) / 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: getAction(index),
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            border: Border.all(color: Colors.white60)),
                        child: Container(
                            height: 34,
                            width: 34,
                            margin: EdgeInsets.all(4),
                            child: SvgPicture.asset(
                              getImageAsset(index),
                              color: isApproved ? primaryColor : Colors.white54,
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            )),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        getTitleButton(index),
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                            fontSize: 13,
                            color: isApproved ? Colors.white : Colors.white70),
                      ),
                      index == 5
                          ? Container(
                              margin: EdgeInsets.only(top: 2),
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
                              decoration: BoxDecoration(
                                  color: Color(0xff925DF0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Text(
                                "Em breve",
                                style: textStyle.copyWith(
                                    fontSize: 12, color: Colors.white),
                              ))
                          : Container()
                    ],
                  )));
            })

        // Generate 100 widgets that display their index in the List.
        );
  }

  String getTitleButton(int index) {
    switch (index) {
      case 0:
        return "Depositar";
      case 1:
        return "Transferir";
      case 2:
        return "Recarga\nde celular";
      case 3:
        return "Pagar\ncontas";
      case 4:
        return "Cartão\nvirtual";
      case 5:
        return "Pix";
      default:
        return "";
    }
  }

  String getImageAsset(int index) {
    switch (index) {
      case 0:
        return "assets/images/home_images/Depositar.svg";
      case 1:
        return "assets/images/home_images/Transferir.svg";
      case 2:
        return "assets/images/home_images/Recarga_de_celular.svg";
      case 3:
        return "assets/images/home_images/Pagar_contas.svg";
      case 4:
        return "assets/images/marketplace/Assinatura.svg";
      case 5:
        return "assets/images/home_images/pix.svg";

      default:
        return "";
    }
  }

  Function() getAction(int index) {
    if (!isApproved) {
      return () {
        SnackBarUtils.showSnackBar(
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          desc: "Para acessar é necessário ativar sua conta.",
          title: "Atenção",
          color: Colors.orange[400],
        );
      };
    }
    switch (index) {
      case 0:
        return () {
          Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY,
              arguments: {"type": "deposit"});
        };
      case 1:
        return () {
          Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY,
              arguments: {"type": "transfer"});
        };
      case 2:
        return () {
          Get.toNamed(Routes.RECHARGE_PHONE_NUMBER);
        };

      case 3:
        return () {
          Get.toNamed(Routes.PAYMENT_READ_BAR_CODE);
        };
      case 4:
        return () {
          Get.toNamed(Routes.WALLET_CARDS);
        };
      case 5:
        return () {
          SnackBarUtils.showSnackBar(
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            desc:
                'Estamos finalizando o PIX, e em breve estará disponível para você!',
            title: "Em breve",
            color: Colors.orange[400],
          );
        };
      default:
        return () {};
    }
  }
}
