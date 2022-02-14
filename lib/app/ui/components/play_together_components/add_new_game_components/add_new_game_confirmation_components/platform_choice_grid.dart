import 'package:cGamer/app/data/models/play_together_models/add_game_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class PlatformChoiceGrid extends StatelessWidget {
  final List<AddGamePlatform> platforms;
  final Function(int) onTap;

  PlatformChoiceGrid({Key? key, required this.platforms, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeigthSize * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Escolha sua plataforma",
            style: textStyle,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: platforms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.4, crossAxisCount: 3),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color:
                              platforms[index].isSelected ? primaryColor : null,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9),
                        onTap: () {
                          onTap(index);
                        },
                        child: Center(
                          child: Text(
                            platforms[index].title ?? "",
                            style: textStyle,
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
