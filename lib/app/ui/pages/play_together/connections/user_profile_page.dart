import 'package:cGamer/app/controllers/play_together_controllers/add_game_confirmation_controller/add_game_confirmation_controller.dart';
import 'package:cGamer/app/controllers/play_together_controllers/connections_controllers/user_profile_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/textfield_component.dart';
import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final UserProfileController controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: Obx(() => CustomAppBar(
                appBarTxt: controller.userProfileModel.value.nickName == null
                    ? "Carregando..."
                    : "Perfil de ${controller.userProfileModel.value.nickName?.split(" ")[0]}")),
            preferredSize: Size.fromHeight(60),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: CircleAvatar(
                                backgroundColor: secondaryColor,
                                child:
                                    controller.userProfileModel.value.avatar ==
                                                null ||
                                            controller.userProfileModel.value
                                                    .avatar ==
                                                ""
                                        ? Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SvgPicture.asset(
                                              'assets/images/tab_bar_icons/Perfil.svg',
                                              fit: BoxFit.contain,
                                              color: primaryColor,
                                              height: 24,
                                              width: 24,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(95.0),
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                      .userProfileModel
                                                      .value
                                                      .avatar ??
                                                  "https://i.ibb.co/x5CpK1w/image-profile.png",
                                              fit: BoxFit.cover,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                              ),
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              child: CachedNetworkImage(
                                  imageUrl: controller.userProfileModel.value
                                          .level?.newFrameUrl ??
                                      "",
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height: 50,
                                  width: 50,
                                  cacheKey: controller.userProfileModel.value
                                          .level?.newFrameUrl ??
                                      "",
                                  useOldImageOnUrlChange: true,
                                  fit: BoxFit.cover),
                            )
                          ],
                        ),
                        // controller.userProfileModel.value.nickName != null
                        //     ? Image.network(
                        //         controller.userProfileModel.value.avatar ??
                        //             "https://i.ibb.co/x5CpK1w/image-profile.png",
                        //         height: 100,
                        //         width: 100,
                        //         fit: BoxFit.fill,
                        //       )
                        //     : Container(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          controller.userProfileModel.value.nickName ?? "",
                          style: textStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        controller.userProfileModel.value.userName != null
                            ? Text(
                                '@' +
                                    (controller
                                            .userProfileModel.value.userName ??
                                        ""),
                                style: textStyle.copyWith(fontSize: 14),
                              )
                            : Container(),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.userProfileModel.value.isEmbaixador
                                    ? Container(
                                        margin: EdgeInsets.only(right: 4),
                                        child: TagEmbaixador(isFull: true))
                                    : Container(),
                                controller.userProfileModel.value.isPrime
                                    ? Container(child: TagPrime())
                                    : Container(),
                              ],
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        controller.userProfileModel.value.statusInvite ==
                                    null ||
                                controller
                                        .userProfileModel.value.statusInvite ==
                                    "RECUSED"
                            ? controller.userProfileModel.value.nickName !=
                                        null &&
                                    controller.customerId !=
                                        controller.myCustomerId
                                ? Container(
                                    width: 180,
                                    child: GenericButton(
                                        height: 40,
                                        icon: Icons.person_add,
                                        text: 'Adicionar amigo',
                                        onPressedFunction: () async {
                                          await controller.sendInviteFriend();
                                        }))
                                : Container()
                            : controller.userProfileModel.value.statusInvite ==
                                    "ACCEPT"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GenericButton(
                                          height: 40,
                                          icon: Icons.send,
                                          text: 'Mensagem',
                                          onPressedFunction: () async {
                                            await controller.sendMessageUser();
                                          }),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GenericButton(
                                          height: 40,
                                          color: Colors.white70,
                                          icon: Icons.remove_circle_outline,
                                          text: 'Excluir amigo',
                                          onPressedFunction: () async {
                                            await controller.removeFriend();
                                          })
                                    ],
                                  )
                                : Container(
                                    width: 180,
                                    child: GenericButton(
                                        height: 40,
                                        enabled: false,
                                        icon: Icons.person_add,
                                        text: 'Pedido enviado',
                                        onPressedFunction: () {
                                          SnackBarUtils.showSnackBar(
                                              desc:
                                                  'Você já enviou um pedido de amizade, aguarde-o ser aceito.',
                                              title: "Atenção");
                                        })),
                        SizedBox(
                          height: 16,
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.userProfileModel.value.cla != null
                            ? Text(
                                "Clã",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                                textAlign: TextAlign.left,
                              )
                            : Container(),
                        controller.userProfileModel.value.cla != null
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.OTHER_CLAN,
                                      preventDuplicates: false,
                                      arguments: {
                                        'clanId': controller
                                            .userProfileModel.value.cla?.id,
                                        'userHasClan': false,
                                      });
                                  // Get.offNamedUntil(
                                  //     Routes.OTHER_CLAN,
                                  //     (route) =>
                                  //         route.settings.name ==
                                  //         Routes.MAIN_PAGES_HOLDER,
                                  //     arguments: {
                                  //       'clanId': controller
                                  //           .userProfileModel.value.cla?.id
                                  //     });
                                },
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: primaryColor, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child: Image.network(
                                                      controller
                                                              .userProfileModel
                                                              .value
                                                              .cla
                                                              ?.logo ??
                                                          "")),
                                              SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      controller
                                                              .userProfileModel
                                                              .value
                                                              .cla
                                                              ?.name ??
                                                          "",
                                                      style:
                                                          textStyle.copyWith()),
                                                  SizedBox(height: 4),
                                                  Row(children: [
                                                    Image.asset(
                                                      'assets/images/gamification_icons/trophy.png',
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      controller
                                                              .userProfileModel
                                                              .value
                                                              .cla
                                                              ?.qtdTrophy
                                                              .toString() ??
                                                          "",
                                                      style: textStyle.copyWith(
                                                          fontSize: 14),
                                                    )
                                                  ])
                                                ],
                                              ),
                                            ]),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Colors.white,
                                        )
                                      ],
                                    )))
                            : Container(),
                        controller.userProfileModel.value.badges != null &&
                                (controller.userProfileModel.value.badges
                                            ?.length ??
                                        0) >
                                    0
                            ? Text(
                                "Badges de ${controller.userProfileModel.value.nickName?.split(" ")[0]}",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                                textAlign: TextAlign.left,
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        controller.userProfileModel.value.badges == null ||
                                (controller.userProfileModel.value.badges
                                            ?.length ??
                                        0) ==
                                    0
                            ? Container()
                            : Center(
                                child: Container(
                                    height: 100,
                                    width: screenWidthhSize,
                                    child: ListView.builder(
                                      itemCount: controller.userProfileModel
                                              .value.badges?.length ??
                                          0,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Column(children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Image.network(controller
                                                  .userProfileModel
                                                  .value
                                                  .badges?[index]
                                                  .image ??
                                              ""),
                                        ),
                                        Text(
                                            controller.userProfileModel.value
                                                    .badges?[index].title ??
                                                "",
                                            style: textStyle.copyWith(
                                                fontSize: 14))
                                      ]),
                                    )))
                      ]),
                  SizedBox(height: 16),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.userProfileModel.value.games != null &&
                                (controller.userProfileModel.value.games
                                            ?.length ??
                                        0) >
                                    0
                            ? Text(
                                "Jogos que ${controller.userProfileModel.value.nickName?.split(" ")[0]} gosta de jogar",
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                                textAlign: TextAlign.left,
                              )
                            : Container(),
                        SizedBox(
                          height: 16,
                        ),
                        controller.userProfileModel.value.games == null ||
                                (controller.userProfileModel.value.games
                                            ?.length ??
                                        0) ==
                                    0
                            ? Container()
                            : Center(
                                child: Container(
                                    height: (screenWidthhSize / 3) - 20,
                                    width: screenWidthhSize,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            controller.userProfileModel.value
                                                    .games?.length ??
                                                0,
                                            (i) => Container(
                                                  margin: EdgeInsets.all(4),
                                                  width:
                                                      (screenWidthhSize / 3) -
                                                          20,
                                                  height:
                                                      (screenWidthhSize / 3) -
                                                          20,
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
                                                              Radius.circular(
                                                                  8)),
                                                      child: Image.network(
                                                        controller
                                                                .userProfileModel
                                                                .value
                                                                .games?[i]
                                                                .image ??
                                                            "https://s2.glbimg.com/6fc58fLCP3uBgR2P4hwsRhzFwro=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2020/s/6/6oNWDSQkO6lkGKQSKeNg/free-fire.jpg",
                                                        fit: BoxFit.cover,
                                                      )),
                                                )))))
                      ])
                ],
              ),
            ),
          ),
        )));
  }
}
