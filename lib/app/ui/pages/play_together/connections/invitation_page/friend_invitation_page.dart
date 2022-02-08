import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/pages/play_together/connections/connection_chat/connection_chat.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FriendInvitationPage extends StatelessWidget {
  const FriendInvitationPage(
      {Key? key,
      required this.player,
      required this.commonGames,
      required this.recusedTap,
      required this.acceptTap,
      required this.loading})
      : super(key: key);

  final MatchPlayer? player;
  final List<CommonGame>? commonGames;
  final Function() recusedTap;
  final Function() acceptTap;
  final RxBool loading;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: 'Convite de amizade',
            ),
            preferredSize: Size.fromHeight(60),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomRichText(
                        normalText: "\nquer ser seu(sua) amigo(a)",
                        customText: player?.nickName ?? "",
                        textAlign: TextAlign.center,
                        customFirst: true,
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.network(
                        player?.avatar ??
                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        player?.nickName ?? "",
                        style: textStyle,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '@' + (player?.userName ?? ""),
                        style: textStyle.copyWith(fontSize: 14),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              player?.isEmbaixador ?? false
                                  ? Container(
                                      margin: EdgeInsets.only(right: 4),
                                      child: TagEmbaixador(isFull: true))
                                  : Container(),
                              player?.isPrime ?? false
                                  ? Container(child: TagPrime())
                                  : Container(),
                            ],
                          )),

                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Icon(
                      //       Icons.gps_fixed,
                      //       color: primaryColor,
                      //     ),
                      //     SizedBox(
                      //       width: 4,
                      //     ),
                      //     Text(
                      //       "4.5 Km",
                      //       style: textStyle.copyWith(fontSize: 13),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 16,
                      ),
                      // SizedBox(
                      //   width: screenWidthhSize * 0.5,
                      //   height: 40,
                      //   child: GenericButton(
                      //     text: player?.from == "FASTMATCH"
                      //         ? "Partida rápida"
                      //         : "Próximo a mim",
                      //     txtColor: Colors.white,
                      //     onPressedFunction: () {},
                      //     isTransparentButton: true,
                      //   ),
                      // ),
                      SizedBox(
                        height: 24,
                      ),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonGames != null && (commonGames?.length ?? 0) > 0
                          ? Text(
                              "Jogos que gosta de jogar",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                          : Container(),
                      SizedBox(
                        height: 16,
                      ),
                      commonGames == null || (commonGames?.length ?? 0) == 0
                          ? Container()
                          : Center(
                              child: Container(
                                  height: (screenWidthhSize / 3) - 20,
                                  width: screenWidthhSize,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                          commonGames?.length ?? 0,
                                          (i) => Container(
                                                margin: EdgeInsets.all(4),
                                                width:
                                                    (screenWidthhSize / 3) - 20,
                                                height:
                                                    (screenWidthhSize / 3) - 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primaryColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    child: Image.network(
                                                      commonGames?[i].image ??
                                                          "https://s2.glbimg.com/6fc58fLCP3uBgR2P4hwsRhzFwro=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2020/s/6/6oNWDSQkO6lkGKQSKeNg/free-fire.jpg",
                                                      fit: BoxFit.cover,
                                                    )),
                                              )))))
                    ])
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: GenericButton(
                    text: "Recusar",
                    isTransparentButton: true,
                    onPressedFunction: recusedTap,
                    txtColor: Colors.white,
                  )),
                  VerticalDivider(
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: GenericButton(
                      text: "Aceitar",
                      color: primaryColor,
                      onPressedFunction: acceptTap,
                      txtColor: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
