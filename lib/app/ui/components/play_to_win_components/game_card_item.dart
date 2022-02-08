import 'package:cGamer/app/controllers/play_to_win/play_to_win_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class GameCardItem extends StatelessWidget {
  final String assetImage;
  final PlayToWinController controller;
  final bool isSelected;
  GameCardItem(
      {required this.assetImage,
      required this.controller,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: isSelected
              ? Border.all(width: 2, color: primaryColor)
              : Border.all(color: Colors.transparent)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            assetImage,
            fit: BoxFit.fill,
          )),
    );
  }
}
