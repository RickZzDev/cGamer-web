import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/found_search_controller.dart';
import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/search_player_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FoundPlayerPage extends StatefulWidget {
  const FoundPlayerPage({Key? key}) : super(key: key);

  @override
  State<FoundPlayerPage> createState() => _FoundPlayerPageState();
}

class _FoundPlayerPageState extends State<FoundPlayerPage> {
  final FoundSearchController controller = Get.find<FoundSearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: "Jogue Junto",
            ),
            preferredSize: Size.fromHeight(60),
          ),
          body: Obx(() => SingleChildScrollView(
                child: controller.inviteSuccessful.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Parabéns!",
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              controller.from == "FASTMATCH"
                                  ? "Um convite foi enviado para \n${controller.searchFastmodel?.playerMatch?.nickName}"
                                  : "Um convite foi enviado para \n${controller.nearByPlayer?.nickName}",
                              style: textStyle.copyWith(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 200,
                              child: Lottie.asset(
                                  'assets/animations/success.json',
                                  repeat: true),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Já avisamos o(a) jogador(a) que \nvocê quer jogar junto! \n\nVocê será notificado(a) quando \n${controller.from == "FASTMATCH" ? controller.searchFastmodel?.playerMatch?.nickName : controller.nearByPlayer?.nickName} aceitar o convite!",
                              style: textStyle.copyWith(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ])
                    : Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "MATCH!",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Mande um convite para \njogar com ${controller.from == "FASTMATCH" ? controller.searchFastmodel?.playerMatch?.nickName : controller.nearByPlayer?.nickName}",
                            style: textStyle.copyWith(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    int? customerId;
                                    if (controller.from == "FASTMATCH") {
                                      customerId = controller.searchFastmodel
                                          ?.playerMatch?.customerId;
                                    } else {
                                      customerId =
                                          controller.nearByPlayer?.customerId;
                                    }
                                    Get.toNamed(Routes.USER_PROFILE,
                                        arguments: {'customerId': customerId});
                                  },
                                  child: MatchedPlayer(
                                    isEmbaixador: controller.from == "FASTMATCH"
                                        ? controller.searchFastmodel
                                                ?.playerMatch?.isEmbaixador ??
                                            false
                                        : controller
                                                .nearByPlayer?.isEmbaixador ??
                                            false,
                                    isPrime: controller.from == "FASTMATCH"
                                        ? controller.searchFastmodel
                                                ?.playerMatch?.isPrime ??
                                            false
                                        : controller.nearByPlayer?.isPrime ??
                                            false,
                                    imageUrl: controller.from == "FASTMATCH"
                                        ? controller.searchFastmodel
                                                ?.playerMatch?.avatar ??
                                            "https://i.ibb.co/x5CpK1w/image-profile.png"
                                        : controller.nearByPlayer?.avatar ??
                                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                                    userName: controller.from == "FASTMATCH"
                                        ? controller.searchFastmodel
                                                ?.playerMatch?.userName ??
                                            ""
                                        : controller.nearByPlayer?.userName ??
                                            "",
                                    nickName: controller.from == "FASTMATCH"
                                        ? controller.searchFastmodel
                                                ?.playerMatch?.nickName ??
                                            ""
                                        : controller.nearByPlayer?.nickName ??
                                            "",
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          controller.from == "FASTMATCH"
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Colors.white70,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                          '${controller.nearByPlayer?.distance}',
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.white70))
                                    ]),
                          SizedBox(
                            height: 24,
                          ),
                          controller.from == "FASTMATCH"
                              ? controller.searchFastmodel?.commonsGames != null
                                  ? Text(
                                      "Jogos em comum",
                                      style: textStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  : Container()
                              : SizedBox(
                                  width: 120,
                                  child: GenericButton(
                                      height: 36,
                                      text: 'Ver perfil',
                                      onPressedFunction: () {
                                        int? customerId;
                                        if (controller.from == "FASTMATCH") {
                                          customerId = controller
                                              .searchFastmodel
                                              ?.playerMatch
                                              ?.customerId;
                                        } else {
                                          customerId = controller
                                              .nearByPlayer?.customerId;
                                        }
                                        Get.toNamed(Routes.USER_PROFILE,
                                            arguments: {
                                              'customerId': customerId
                                            });
                                      })),
                          SizedBox(
                            height: 16,
                          ),
                          controller.from == "FASTMATCH" &&
                                  controller.searchFastmodel?.commonsGames ==
                                      null
                              ? Container()
                              : Center(
                                  child: Container(
                                      height: (screenWidthhSize / 3) - 20,
                                      width: screenWidthhSize,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(
                                              controller.searchFastmodel
                                                      ?.commonsGames?.length ??
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
                                                            color:
                                                                primaryColor),
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
                                                                  .searchFastmodel
                                                                  ?.commonsGames?[
                                                                      i]
                                                                  .image ??
                                                              "https://s2.glbimg.com/6fc58fLCP3uBgR2P4hwsRhzFwro=/1200x/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2020/s/6/6oNWDSQkO6lkGKQSKeNg/free-fire.jpg",
                                                          fit: BoxFit.cover,
                                                        )),
                                                  )))))
                        ],
                      ),
              )),
          bottomNavigationBar: controller.inviteSuccessful.value
              ? Container(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      Text(
                        "Lembre-se, a conversa é iniciada \napós o aceite do convite, em Conexões.",
                        style: textStyle.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GenericButton(
                          text: "OK, entendi",
                          txtColor: secondaryColor,
                          icon: Icons.check,
                          color: primaryColor,
                          onPressedFunction: () {
                            Navigator.pop(Get.context!);
                          })
                    ]),
                  ))
              : Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GenericButton(
                              text: controller.from == "FASTMATCH"
                                  ? "Procurar outro"
                                  : "Voltar a lista",
                              txtColor: secondaryColor,
                              icon: controller.from == "FASTMATCH"
                                  ? Icons.my_location_sharp
                                  : Icons.arrow_back,
                              color: Colors.white70,
                              onPressedFunction: () {
                                Navigator.pop(Get.context!);
                                if (controller.from == "FASTMATCH") {
                                  Get.toNamed(Routes.PLAYER_SEARCH, arguments: {
                                    "from": controller.from,
                                    "gameId": controller.gameId,
                                    "gameImage": controller.gameImage.value,
                                    "platformId": controller.platformId
                                  });
                                }
                              }),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                        ),
                        Expanded(
                          child: GenericButton(
                              text: "Mandar convite",
                              icon: Icons.send,
                              txtColor: secondaryColor,
                              onPressedFunction: () {
                                controller
                                    .sendInvite(controller.from == "FASTMATCH");
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
        )));
  }
}
