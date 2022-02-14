import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid_gamer.dart';
import 'package:cGamer/app/ui/components/home_components/home_grid_services.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeGrid extends StatelessWidget {
  HomeGrid({required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 4),
      height: 285,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          // child: HomeGamerGrid(
          //   isApproved: true,
          //   controller: controller,
          // ),
        ),
      ),
    );
  }
}
