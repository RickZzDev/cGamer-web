import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NewsCarousel extends StatelessWidget {
  NewsCarousel({required this.controller});
  final HomeController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidthhSize,
        height: 180,
        margin: EdgeInsets.only(bottom: 24),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          itemBuilder: (context, index) {
            return Container(
                width: screenWidthhSize / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: GestureDetector(
                    onTap: () async {
                      var url = controller?.newsModel.news?[index].url
                          ?.replaceAll('noticias.', '');
                      if (await canLaunch(url ?? ""))
                        await launch(url ?? "");
                      else
                        // can't launch url, there is some error
                        throw "Could not launch";
                    },
                    child: Stack(
                      children: [
                        Container(
                            height: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                child: SizedBox(
                                    child: CachedNetworkImage(
                                        imageUrl: getAssetThumb(controller
                                                ?.newsModel
                                                .news?[index]
                                                .category ??
                                            ""),
                                        fit: BoxFit.cover)))),
                        // Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //           decoration: BoxDecoration(
                        //               color: secondaryColor.withOpacity(0.85),
                        //               borderRadius: BorderRadius.only(
                        //                   topLeft: Radius.circular(8),
                        //                   topRight: Radius.circular(8))),
                        //           alignment: Alignment.center,
                        //           height: 20,
                        //           child: Text(
                        //             controller
                        //                     ?.newsModel.news?[index].category ??
                        //                 "",
                        //             style: textStyle.copyWith(
                        //                 fontSize: 12,
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold),
                        //           )),
                        //     ]),
                        Container(
                            margin: EdgeInsets.only(top: 85),
                            padding: EdgeInsets.only(right: 4, left: 4),
                            decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.75),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller?.newsModel.news?[index].title ??
                                      "",
                                  style: textStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ],
                    )));
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 12,
          ),
          itemCount: controller?.newsModel.news?.length ?? 0,
        ));
  }

  String getAssetThumb(String category) {
    if (category.contains("FreeFire")) {
      return "https://play-lh.googleusercontent.com/Knw_hAyujH2PKqKtOEM5r8oJ_U-enugflHPpAMUr2T1R6Fp3AUPMYlLKm476BYwNt3Wl=w412-h220-rw";
    }
    if (category.contains("CS:GO")) {
      return "http://noticias.maisesports.com.br/wp-content/uploads/2021/07/Baixar-CSGO-download.jpg";
    }
    if (category.contains("League of Legends")) {
      return "https://a.espncdn.com/photo/2021/0811/r894492_960x540_16-9.png";
    }
    if (category.contains("Valorant")) {
      return "https://xboxplay.games/uploadStream/15450.jpg";
    }
    if (category.contains("FreeFire")) {
      return "https://play-lh.googleusercontent.com/Knw_hAyujH2PKqKtOEM5r8oJ_U-enugflHPpAMUr2T1R6Fp3AUPMYlLKm476BYwNt3Wl=w412-h220-rw";
    }
    if (category.contains("Rainbow Six")) {
      return "https://cdn1.epicgames.com/carnation/offer/r6s-y6-epic-std-store-landscape-2560x1440-2560x1440-ada4045f97c2-2560x1440-1a29dde6790c324f62bb12216e651944.jpeg";
    }
    if (category.contains("Fortnite")) {
      return "https://cdn2.unrealengine.com/14br-consoles-1920x1080-wlogo-1920x1080-432974386.jpg";
    }
    if (category.contains("Wild Rift")) {
      return "https://images.contentstack.io/v3/assets/blt370612131b6e0756/blt25c7cb03f8dbb71e/5f5a8d9769d060498b8e4c31/WR_meta_homepage.png";
    }
    if (category.contains("Riot Games")) {
      return "https://arenaesports.com.br/wp-content/uploads/2019/04/novo-logo-riot-games.jpg";
    }

    return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRocw-OvIp2Qx37Uvpkq_YglIb1Z1mOV64PfWjzcITfIJlfv42V4cbYEZ34QXrvQrPNr8E&usqp=CAU";
  }
}
