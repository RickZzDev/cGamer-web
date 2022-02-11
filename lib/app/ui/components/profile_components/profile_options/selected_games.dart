import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedGamesArea extends StatelessWidget {
  final ProfileController _controller;
  final Function _showBottomSheet;
  SelectedGamesArea(this._controller, this._showBottomSheet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jogos favoritos",
                  style: textStyle,
                ),
                GestureDetector(
                  onTap: () => _showBottomSheet(context),
                  child: Text(
                    "Editar jogos",
                    style: textStyle.copyWith(
                        fontSize: 16,
                        color: primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          SelectedGames(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}

class SelectedGames extends StatelessWidget {
  final ProfileController _controller;

  const SelectedGames({
    required ProfileController controller,
    Key? key,
  })  : this._controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeigthSize * 0.1,
      child: Obx(() => _controller.hasCompletedSelectedGames.value
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _controller.selectedGamesList.value.games?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      _controller.selectedGamesList.value.games?[index].image ??
                          "",
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            )),
    );
  }
}
