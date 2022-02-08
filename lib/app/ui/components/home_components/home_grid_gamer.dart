import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/ui/pages/pro/pro_view.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeGamerGrid extends StatelessWidget {
  HomeGamerGrid({required this.isApproved, required this.controller});
  final bool isApproved;
  final HomeController controller;

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
                childAspectRatio: ((screenWidthhSize - 92) / 122) / 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: getAction(index),
                  child: Container(
                      child: Column(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80)),
                              border: Border.all(color: Colors.white60)),
                          child: Container(
                              height: 34,
                              width: 34,
                              margin: EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                getImageAsset(index),
                                color:
                                    isApproved ? primaryColor : Colors.white54,
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                              )),
                        ),
                        index == 3 &&
                                (controller.homeResult.value.totalInvites ??
                                        0) >
                                    0
                            ? Container(
                                transform:
                                    Matrix4.translationValues(20.0, -12.0, 0.0),
                                child: Center(
                                    child: Text(
                                        "${controller.homeResult.value.totalInvites ?? 0}",
                                        style:
                                            textStyle.copyWith(fontSize: 12))),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))))
                            : Container(),
                        // index == 4
                        //     ? TagPrime(
                        //         // transform:
                        //         //     Matrix4.translationValues(20.0, -12.0, 0.0),
                        //         fontSize: 11.0)
                        //     : Container(),
                      ]),
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
                      index == 3
                          ? Container(
                              margin: EdgeInsets.only(top: 2),
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
                              decoration: BoxDecoration(
                                  //color: Colors.deepPurpleAccent,
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Text(
                                "Novidade",
                                style: textStyle.copyWith(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                          : Container(),
                      index == 4
                          ? Container(
                              margin: EdgeInsets.only(top: 2),
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
                              child: TagPrime(fontSize: 12.0))
                          : Container(),
                      index == 1
                          ? Container(
                              margin: EdgeInsets.only(top: 2),
                              padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Text(
                                "Novidade",
                                style: textStyle.copyWith(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                          : Container(),
                    ],
                  )));
            })

        // Generate 100 widgets that display their index in the List.
        );
  }

  String getTitleButton(int index) {
    switch (index) {
      case 0:
        return "Meu\nClã";
      case 1:
        return "Encontre \num Gamer";
      case 2:
        return "Jogue\n e ganhe";
      case 3:
        return "Conexões";
      case 4:
        return "Área";
      case 5:
        return "Indique\num Gamer";

      default:
        return "";
    }
  }

  String getImageAsset(int index) {
    switch (index) {
      case 0:
        return "assets/images/home_images/meucla.svg";
      case 1:
        return "assets/images/home_images/location.svg";
      case 2:
        return "assets/images/tab_bar_icons/Compras.svg";
      case 3:
        return "assets/images/play_together/icon_conexoes.svg";
      case 4:
        return "assets/images/tab_bar_icons/Coroa.svg";
      case 5:
        return "assets/images/profile_images/Indique_Amigo.svg";

      default:
        return "";
    }
  }

  Function()? getAction(int index) {
    // if (!isApproved) {
    //   return () {
    //     SnackBarUtils.showSnackBar(
    //       icon: Icon(
    //         Icons.error_outline,
    //         color: Colors.white,
    //       ),
    //       desc: "Para acessar é necessário ativar sua conta.",
    //       title: "Atenção",
    //       color: Colors.orange[400],
    //     );
    //   };
    // }
    switch (index) {
      case 0:
        return () async {
          ClanInfoModel clanInfo = await controller.getClanInfo();
          if (clanInfo.clanId != null) {
            Get.toNamed(Routes.CLAN_DETAILS,
                preventDuplicates: false,
                arguments: {'clanId': clanInfo.clanId});
          } else {
            Get.toNamed(Routes.CLAN);
          }
        };
      case 2:
        return () => Get.toNamed(Routes.PLAY_TO_WIN);
      case 1:
        return () {
          Get.toNamed(Routes.PLAY_TOGETHER);
        };
      case 3:
        return () {
          Get.toNamed(Routes.CONNECTIONS, arguments: {'fromHome': true});
        };

      case 4:
        return () {
          if (controller.isPrime) {
            Get.toNamed(Routes.PRIME_AREA,
                arguments: {'userStats': controller.homeResult.value});
          } else {
            Navigator.push(
              Get.context!,
              MaterialPageRoute(
                  builder: (context) => ProView(), fullscreenDialog: true),
            );
          }
        };
      case 5:
        return () {
          Get.toNamed(Routes.INVITE_FRIEND);
        };
      default:
        return () {};
    }
  }
}
