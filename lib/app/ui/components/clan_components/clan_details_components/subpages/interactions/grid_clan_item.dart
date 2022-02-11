import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridClanItem extends StatelessWidget {
  final GridClanItemModel model;

  GridClanItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 60,
              child: Padding(
                  padding: EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    getIcon(),
                    fit: BoxFit.contain,
                    width: 24,
                    height: 24,
                    color: primaryColor,
                  )),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(100)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                getTitle(),
                style: textStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  String getTitle() {
    switch (this.model.title) {
      case "recruitMember":
        return "Recrutar \nmembro";
      case "requestEntry":
        return "Solicitações \nde entrada";
      case "rankingOfClans":
        return "Ranking \nde clãns";
      case "manageMembers":
        return "Gerenciar \nmembros";
      case "editClan":
        return "Editar clã";
      case "leftClan":
        return "Sair do clã";
      default:
        return "";
    }
  }

  String getIcon() {
    switch (this.model.title) {
      case "recruitMember":
        return "assets/images/profile_images/Indique_Amigo.svg";
      case "requestEntry":
        return "assets/images/profile_images/Indique_Amigo.svg";
      case "rankingOfClans":
        return "assets/images/tab_bar_icons/Coroa.svg";
      case "manageMembers":
        return "assets/images/home_images/Meu_cla.svg";
      case "editClan":
        return "assets/images/home_images/Meu_cla.svg";
      case "leftClan":
        return "assets/images/profile_images/Sair.svg";
      default:
        return "";
    }
  }
}

class GridClanItemModel {
  final String title;
  final Function() onTap;

  GridClanItemModel(this.title, this.onTap);
}
