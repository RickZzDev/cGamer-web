import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/data/models/play_to_win_models/play_to_win_model.dart';
import 'package:cGamer/app/ui/components/play_to_win_components/game_card_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PlayToWinCarousel extends StatelessWidget {
  final PlayToWinController controller;

  PlayToWinCarousel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Obx(() => controller.hasLoadedGames.value
          ? ListView.separated(
              separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              // itemCount: controller.games?.length ?? 0,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.gameOnTap(
                      controller.games?[index].getGameType() ??
                          PlayToWinGameType.NONE),
                  child: Obx(() => GameCardItem(
                      isSelected: controller.games?[index].getGameType() ==
                          controller.currentGame.value,
                      controller: controller,
                      assetImage:
                          controller.games?[index].assetImageUrl ?? ""))))
          : Shimmer.fromColors(
              highlightColor: Colors.blueGrey[400],
              baseColor: Theme.of(context).accentColor,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return VerticalDivider(
                      color: Colors.transparent,
                    );
                  },
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    );
                  }),
            )),
    );
  }
}
