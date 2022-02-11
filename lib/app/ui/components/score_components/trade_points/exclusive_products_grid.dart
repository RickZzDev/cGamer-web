import 'package:cGamer/app/ui/components/score_components/trade_points/exclusive_product_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExclusiveProductsGrid extends StatelessWidget {
  List<ExclusiveProductButton> buttons = [
    ExclusiveProductButton(
      title: "Platina",
      imagePath: "https://bancogamer.s3.amazonaws.com/BG_Medalhas_Platina.png",
      onTap: () {},
      enabled: false,
    ),
    ExclusiveProductButton(
      title: "Diamante",
      imagePath: "https://bancogamer.s3.amazonaws.com/BG_Medalhas_Diamante.png",
      onTap: () {},
      enabled: false,
    ),
    ExclusiveProductButton(
      title: "Mestre",
      imagePath: "https://bancogamer.s3.amazonaws.com/BG_Medalhas_Master.png",
      onTap: () {},
      enabled: false,
    ),
    ExclusiveProductButton(
      title: "Lendário",
      imagePath: "https://bancogamer.s3.amazonaws.com/Lendario.png",
      onTap: () {},
      enabled: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 24),
        child: GridView.count(
            // Cria um grid com duas colunas
            crossAxisCount: 2,
            primary: false,
            shrinkWrap: true,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: (250 / 180),
            padding: EdgeInsets.only(right: 24, left: 24),
            children: List.generate(buttons.length, (index) {
              return buttons[index];
            })));
  }
}
