import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/connections_controller.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/chat/clan_chat.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/chat/direct_chat.dart';
import 'package:cGamer/app/ui/pages/pages.dart';
import 'package:cGamer/app/ui/pages/play_together/connections/connection_chat/connection_chat.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../../components.dart';

class ConversationSubpage extends StatelessWidget {
  const ConversationSubpage({Key? key, required this.controller})
      : super(key: key);
  final ConnectionController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => controller.getMatchInvites(),
        child: Container(
          color: secondaryColor,
          child: ListView(
            children: [
              Obx(() => CustomRichText(
                    normalText:
                        "(${controller.matchInvitesModel.value.invites?.length ?? 0})",
                    customText: "Convites para jogar",
                    customFirst: true,
                  )),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller
                              .matchInvitesModel.value.invites?.length !=
                          null
                      ? controller.matchInvitesModel.value.invites?.length == 0
                          ? 1
                          : controller.matchInvitesModel.value.invites?.length
                      : 1,
                  itemBuilder: (context, index) {
                    if (controller.matchInvitesModel.value.invites == null ||
                        controller.matchInvitesModel.value.invites?.length ==
                            0) {
                      return Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: Text('Você não tem nenhum convite para jogar.',
                              style: textStyle.copyWith(fontSize: 14)));
                    }
                    return InvitationItem(
                        isEmbaixador: controller.matchInvitesModel.value
                                .invites?[index].player?.isEmbaixador ??
                            false,
                        platformId: controller.matchInvitesModel.value
                                .invites?[index].platformId ??
                            -1,
                        gameName: controller.matchInvitesModel.value.invites?[index].gameName ??
                            "",
                        customerId: controller.matchInvitesModel.value
                                .invites?[index].player?.customerId ??
                            -1,
                        isPrime: controller.matchInvitesModel.value
                                .invites?[index].player?.isPrime ??
                            false,
                        urlImage: controller.matchInvitesModel.value
                                .invites?[index].player?.avatar ??
                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                        userName: controller.matchInvitesModel.value.invites?[index].player?.userName ?? "",
                        nickName: controller.matchInvitesModel.value.invites?[index].player?.nickName ?? "",
                        action: () => Get.to(() => InvitationPage(
                              player: controller.matchInvitesModel.value
                                  .invites?[index].player,
                              commonGames: controller.matchInvitesModel.value
                                  .invites?[index].commonsGames,
                              loading: controller.loading,
                              acceptTap: () {
                                controller.acceptMatchInvite(controller
                                    .matchInvitesModel.value.invites?[index]);
                              },
                              recusedTap: () {
                                controller.recuseMatchInvite(controller
                                    .matchInvitesModel.value.invites?[index]);
                              },
                            )));
                  }),
              SizedBox(
                height: 24,
              ),
              Text(
                "Conversas",
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder<List<types.Room>>(
                  stream: controller.rooms(orderByUpdatedAt: true),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: Text('Nenhuma conversa foi iniciada ainda.',
                              style: textStyle.copyWith(fontSize: 14)));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final room = snapshot.data![index];

                          if (room.lastMessages?[0].toJson()['text'] == null) {
                            return Container();
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DirectChatPage(
                                    room: room,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                child: ConversationItem(
                                    urlImage: room.imageUrl ?? "",
                                    userName: room.name ?? "",
                                    message: room.lastMessages?[0]
                                            .toJson()['text'] ??
                                        "Envie sua primeira mensagem")),
                          );
                        });
                  })
            ],
          ),
        ));
  }
}
