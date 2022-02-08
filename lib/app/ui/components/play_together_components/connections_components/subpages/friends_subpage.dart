import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/connections_controller.dart';
import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/play_together_components/connections_components/conversation_components/friend_item.dart';
import 'package:cGamer/app/ui/pages/play_together/connections/invitation_page/friend_invitation_page.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components.dart';

class FriendsSubPage extends StatelessWidget {
  const FriendsSubPage({Key? key, required this.controller}) : super(key: key);
  final ConnectionController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await controller.getFriends();
          await controller.getFriendInvites();
        },
        child: Container(
          color: secondaryColor,
          child: ListView(
            children: [
              Obx(() => CustomRichText(
                    normalText:
                        "(${controller.friendInvitesModel.value.invites?.length ?? 0})",
                    customText: "Pedidos de amizade",
                    customFirst: true,
                  )),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller
                              .friendInvitesModel.value.invites?.length !=
                          null
                      ? controller.friendInvitesModel.value.invites?.length == 0
                          ? 1
                          : controller.friendInvitesModel.value.invites?.length
                      : 1,
                  itemBuilder: (context, index) {
                    if (controller.friendInvitesModel.value.invites == null ||
                        controller.friendInvitesModel.value.invites?.length ==
                            0) {
                      return Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: Text(
                              'Nenhum não tem nenhum pedido de amizade.',
                              style: textStyle.copyWith(fontSize: 14)));
                    }
                    return InvitationItem(
                        isEmbaixador: controller.friendInvitesModel.value
                                .invites?[index].isEmbaixador ??
                            false,
                        customerId: controller.friendInvitesModel.value
                                .invites?[index].customerId ??
                            -1,
                        isPrime: controller.friendInvitesModel.value
                                .invites?[index].isPrime ??
                            false,
                        urlImage: controller.friendInvitesModel.value
                                .invites?[index].avatar ??
                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                        userName: controller.friendInvitesModel.value
                                .invites?[index].userName ??
                            "",
                        nickName: controller.friendInvitesModel.value
                                .invites?[index].nickName ??
                            "",
                        action: () {
                          MatchPlayer player = MatchPlayer();
                          player.avatar = controller
                              .friendInvitesModel.value.invites?[index].avatar;
                          player.nickName = controller.friendInvitesModel.value
                              .invites?[index].nickName;
                          player.userName = controller.friendInvitesModel.value
                              .invites?[index].userName;
                          player.isPrime = controller.friendInvitesModel.value
                                  .invites?[index].isPrime ??
                              false;
                          player.isEmbaixador = controller.friendInvitesModel
                                  .value.invites?[index].isEmbaixador ??
                              false;

                          Get.to(() => FriendInvitationPage(
                                player: player,
                                commonGames: controller.friendInvitesModel.value
                                    .invites?[index].commonsGames,
                                loading: controller.loading,
                                acceptTap: () {
                                  controller.acceptFriendInvite(controller
                                      .friendInvitesModel
                                      .value
                                      .invites?[index]);
                                },
                                recusedTap: () {
                                  controller.recuseFriendInvite(controller
                                          .friendInvitesModel
                                          .value
                                          .invites?[index]
                                          .customerId ??
                                      0);
                                },
                              ));
                        });
                  }),
              SizedBox(
                height: 24,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Amigos ${controller.friendsModel.value.invites?.length != null ? controller.friendsModel.value.invites?.length == 0 ? "" : "(${controller.friendsModel.value.invites?.length})" : ""}",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SEARCH_FRIENDS);
                    },
                    child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(color: primaryColor)),
                        child: Row(children: [
                          Icon(Icons.search, color: primaryColor, size: 16),
                          SizedBox(width: 4),
                          Container(
                              margin: EdgeInsets.only(bottom: 2),
                              child: Text('procurar amigos',
                                  style: textStyle.copyWith(
                                      fontSize: 14, color: primaryColor)))
                        ]))),
              ]),
              SizedBox(
                height: 8,
              ),
              // StreamBuilder<List<types.Room>>(
              //     stream: controller.rooms(orderByUpdatedAt: true),
              //     initialData: const [],
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //         return Container(
              //             alignment: Alignment.center,
              //             margin: const EdgeInsets.only(
              //               top: 20,
              //             ),
              //             child: Text('Nenhuma conversa foi iniciada',
              //                 style: textStyle.copyWith(fontSize: 16)));
              //       }

              ListView.builder(
                  itemCount:
                      controller.friendsModel.value.invites?.length != null
                          ? controller.friendsModel.value.invites?.length == 0
                              ? 1
                              : controller.friendsModel.value.invites?.length
                          : 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (controller.friendsModel.value.invites == null ||
                        controller.friendsModel.value.invites?.length == 0) {
                      return Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: Text('Nenhum amigo foi adicionado ainda.',
                              style: textStyle.copyWith(fontSize: 14)));
                    }
                    final friend =
                        controller.friendsModel.value.invites?[index];

                    return FriendItem(
                        customerId: friend?.customerId ?? -1,
                        urlImage: friend?.avatar ??
                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                        userName: friend?.userName ?? "",
                        nickName: friend?.nickName ?? "",
                        isPrime: friend?.isPrime ?? false,
                        isEmbaixador: friend?.isEmbaixador ?? false,
                        openChat: () async {
                          await controller.openFriendChat(friend!);
                        });
                  })
            ],
          ),
        ));
  }
}
