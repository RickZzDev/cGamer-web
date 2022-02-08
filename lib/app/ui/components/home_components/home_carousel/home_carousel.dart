import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  HomeCarousel({required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: CarouselSlider(
        items: [
          DiscordItem(),
          HomeBottomBanner(controller: controller),
        ],
        options: CarouselOptions(
          height: 150,
          enableInfiniteScroll: true,
          viewportFraction: 0.8,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
