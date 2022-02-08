import 'package:cGamer/app/ui/components/marketplace/carousel_banner_component.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselBannerProductsComponent extends StatelessWidget {
  const CarouselBannerProductsComponent(
      {Key? key, required List<CarouselBanner> items})
      : _items = items,
        super(key: key);

  final List<CarouselBanner> _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 20),
      child: CarouselSlider(
          items: _items,
          options: CarouselOptions(
            height: 120,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInBack,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),

      // child:
    );
  }
}
