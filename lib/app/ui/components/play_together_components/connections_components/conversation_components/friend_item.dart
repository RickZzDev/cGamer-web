import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendItem extends StatelessWidget {
  final String userName;
  final String nickName;
  final String urlImage;
  final int customerId;
  final bool isPrime;
  final bool isEmbaixador;
  final Function() openChat;

  FriendItem(
      {Key? key,
      required this.customerId,
      required this.userName,
      required this.nickName,
      required this.urlImage,
      required this.openChat,
      required this.isPrime,
      required this.isEmbaixador})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
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
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                        SizedBox(height: 4),
                        Row(children: [
                          isEmbaixador
                              ? Container(
                                  margin: EdgeInsets.only(right: 4),
                                  child: TagEmbaixador(
                                    fontSize: 12.0,
                                  ))
                              : Container(),
                          isPrime
                              ? Container(
                                  margin: EdgeInsets.only(right: 4),
                                  child: TagPrime(fontSize: 12.0))
                              : Container(),
                          Container(
                              child: Text(
                            '@' + userName,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white70),
                          ))
                        ])
                      ],
                    )
                  ],
                ),
                IconButton(
                    iconSize: 30,
                    onPressed: openChat,
                    icon: Icon(
                      Icons.chat,
                      color: primaryColor,
                    ))
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
}
