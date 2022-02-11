import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/found_search_controller.dart';
import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/near_by_search_controller.dart';
import 'package:cGamer/app/controllers/play_together_controllers/search_player_controller/search_player_controller.dart';
import 'package:cGamer/app/data/models/play_together_models/search_player_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/play_together_components/found_player_components.dart/nearby_player.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/pages/pages.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class NearbyPlayersPage extends StatefulWidget {
  const NearbyPlayersPage({Key? key}) : super(key: key);

  @override
  State<NearbyPlayersPage> createState() => _NearbyPlayersPageState();
}

class _NearbyPlayersPageState extends State<NearbyPlayersPage> {
  final NearbySearchController controller = Get.find<NearbySearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: PreferredSize(
            child: CustomAppBar(
              appBarTxt: "Próximos a mim",
            ),
            preferredSize: Size.fromHeight(60),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  width: screenWidthhSize,
                  child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: primaryColor)),
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.network(
                                        controller.gameImage.value,
                                        fit: BoxFit.cover))),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              (controller.nearbyPlayersModel?.players?.length !=
                                          null &&
                                      controller.nearbyPlayersModel!.players!
                                              .length >
                                          0)
                                  ? "Confira os jogadores que \nestão próximos a você.. "
                                  : "No momento nenhum jogador foi \nencontrado próximo a você.",
                              maxLines: 2,
                              style: textStyle.copyWith(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ]))),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.nearbyPlayersModel?.players?.length ?? 0,
                    itemBuilder: (context, index) {
                      return NearByPlayerItem(
                        isEmbaixador: controller.nearbyPlayersModel
                                ?.players?[index].isEmbaixador ??
                            false,
                        isPrime: controller
                                .nearbyPlayersModel?.players?[index].isPrime ??
                            false,
                        customerId: controller.nearbyPlayersModel
                                ?.players?[index].customerId ??
                            -1,
                        nickName: controller
                                .nearbyPlayersModel?.players?[index].nickName ??
                            "",
                        urlImage: controller
                                .nearbyPlayersModel?.players?[index].avatar ??
                            "https://i.ibb.co/x5CpK1w/image-profile.png",
                        userName: controller
                                .nearbyPlayersModel?.players?[index].userName ??
                            "",
                        distance: controller
                                .nearbyPlayersModel?.players?[index].distance ??
                            "N/A",
                        openSendInvite: () {
                          Get.toNamed(Routes.FOUND_PLAYER, arguments: {
                            'model':
                                controller.nearbyPlayersModel?.players?[index],
                            'platformId': controller.platformId,
                            'gameId': controller.gameId,
                            'gameImage': controller.gameImage.value,
                            'from': 'NEARBY'
                          });
                        },
                      );
                    },
                  ))
            ],
          )),
        )));
  }
}
