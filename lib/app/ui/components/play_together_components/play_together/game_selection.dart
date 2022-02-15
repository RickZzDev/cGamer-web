import 'package:cGamer/app/controllers/play_together_controllers/edit_game_controller/edit_game_controller.dart';
import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameSelection extends StatelessWidget {
  var games;
  final int? platformId;
  final Function(bool, int)? onTapToSelect;
  GameSelection({
    Key? key,
    required this.games,
    this.platformId,
    this.onTapToSelect,
  }) : super(key: key);

  var indexSelected = 99999.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecione um dos seus jogos abaixo",
            style: textStyle,
          ),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: games.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          if (indexSelected.value == 99999) {
                            Get.toNamed(Routes.ADD_NEW_GAME, arguments: {
                              'platformId': this.platformId,
                            });
                          } else {
                            Get.toNamed(Routes.EDIT_A_GAME,
                                arguments: EditGameModel(
                                    game: games[indexSelected.value - 1],
                                    platformId: platformId ?? 0));
                          }
                        } else {
                          if (indexSelected.value == 99999 ||
                              indexSelected.value != index) {
                            indexSelected.value = index;
                            onTapToSelect!(true, index);
                          } else {
                            onTapToSelect!(false, index);
                            indexSelected.value = 99999;
                          }
                        }
                      },
                      child: Obx(
                        () => Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: indexSelected.value == index ? 2.5 : 1,
                                  color:
                                      indexSelected.value == index || index == 0
                                          ? primaryColor
                                          : Colors.transparent)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: index == 0
                                ? Obx(() => Icon(
                                      indexSelected.value == 99999
                                          ? Icons.add
                                          : Icons.edit,
                                      size: indexSelected.value == 99999
                                          ? 50
                                          : 36,
                                      color: primaryColor,
                                    ))
                                : Image.network(
                                    games[index - 1].image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
