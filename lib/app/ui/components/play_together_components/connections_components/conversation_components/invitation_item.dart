import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InvitationItem extends StatelessWidget {
  final String urlImage;
  final String nickName;
  final String userName;
  final bool isPrime;
  final bool isEmbaixador;
  final int customerId;
  final int? platformId;
  final String? gameName;
  final Function() action;

  const InvitationItem(
      {Key? key,
      required this.urlImage,
      required this.userName,
      required this.nickName,
      required this.action,
      required this.isPrime,
      required this.isEmbaixador,
      required this.customerId,
      this.gameName,
      this.platformId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.USER_PROFILE,
                              arguments: {'customerId': customerId});
                        },
                        child: Image.network(
                          this.urlImage,
                          height: 48,
                          width: 48,
                          fit: BoxFit.fill,
                        )),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nickName,
                          style: textStyle,
                        ),
                        Row(children: [
                          isEmbaixador
                              ? Container(
                                  margin: EdgeInsets.only(right: 4),
                                  child: TagEmbaixador(fontSize: 12.0))
                              : Container(),
                          isPrime
                              ? Container(
                                  margin: EdgeInsets.only(right: 4, top: 2),
                                  child: TagPrime(fontSize: 12.0))
                              : Container(),
                          Text(
                            '@' + userName,
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white70),
                          )
                        ]),
                        platformId != null
                            ? Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Row(children: [
                                  SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: SvgPicture.asset(
                                          getIconWithIndex(platformId ?? -1))),
                                  SizedBox(width: 4),
                                  Text(
                                    gameName ?? "",
                                    style: textStyle.copyWith(
                                        fontSize: 12, color: Colors.white70),
                                  )
                                ]))
                            : Container(),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: 75,
                        child: GenericButton(
                          height: 24,
                          text: "Ver",
                          onPressedFunction: action,
                        )),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: primaryColor,
          )
        ],
      ),
    );
  }

  getIconWithIndex(int index) {
    switch (index) {
      case 1:
        return 'assets/images/play_together/mobile.svg';
      case 2:
        return 'assets/images/play_together/pc.svg';
      case 3:
        return 'assets/images/play_together/playstation.svg';
      case 4:
        return 'assets/images/play_together/xbox.svg';
      case 5:
        return 'assets/images/play_together/nintendo.svg';

      default:
        return '';
    }
  }
}
