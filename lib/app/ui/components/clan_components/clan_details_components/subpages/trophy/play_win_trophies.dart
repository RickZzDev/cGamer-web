import 'package:cGamer/app/controllers/clan_controllers/clan_details_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/score/score_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/clan_components/clan_details_components/subpages/trophy/play_win_trophy_item.dart';
import 'package:cGamer/app/ui/components/score_components/score_sub_pages/how_to_win_components/how_to_win_card.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/data/models/score_models/how_earn_model.dart';
import 'package:get/get.dart';

class PlayWinTrophies extends StatelessWidget {
  final ClanDetailsController _controller;
  PlayWinTrophies(this._controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _controller.playWinTrophyList.length,
            itemBuilder: (context, index) {
              int? timestamp;
              if ((_controller.playWinTrophyList[index].containsCounter ??
                      false) &&
                  _controller.playWinTrophyList[index].lastActionDate != null) {
                timestamp = _controller.getTimeLeft(
                    _controller.playWinTrophyList[index].lastActionDate);
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: PlayWinTropyCard(
                    timestamp: timestamp,
                    isBenefitsPrime:
                        index == _controller.playWinTrophyList.length - 1
                            ? false
                            : true,
                    isPrime: _controller.isPrime,
                    containsCounter:
                        _controller.playWinTrophyList[index].containsCounter ??
                            false,
                    text: _controller.playWinTrophyList[index].title,
                    buttonTitle:
                        _controller.playWinTrophyList[index].buttonTitle,
                    description:
                        _controller.playWinTrophyList[index].description,
                    hasBorder: index == _controller.playWinTrophyList.length - 1
                        ? false
                        : true,
                    onTap: () => _actionVerifier(
                        _controller.playWinTrophyList[index].action)),
              );
            }),
      ],
    );
  }

  dynamic _actionVerifier(String? action) async {
    switch (action) {
      case "ROULETTE":
        Get.toNamed(Routes.CLAN_ROULETTE);
        break;

      case "AUTOMATIC":
        await _controller.rescueTrophy();
        break;

      case "VELHA":
        Get.toNamed(Routes.CLAN_JOGO_VELHA);
        break;
      case "CACA_TROPHY":
        Get.toNamed(Routes.CLAN_TROPHY_HUNT);
        break;

      case "QUIZ":
        Get.toNamed(Routes.CLAN_QUIZ);
        break;

      default:
        break;
    }
  }
}
