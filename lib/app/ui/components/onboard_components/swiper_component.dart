import 'package:cGamer/app/data/models/onboard_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class SwiperComponent extends StatelessWidget {
  SwiperComponent({
    required SwiperController swipperController,
  }) : _swipperController = swipperController;

  final SwiperController _swipperController;
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Provider.of<List<OnBoardModel>>(context,
                                    listen: false)[index]
                                .imgType ==
                            "svg"
                        ? SvgPicture.asset(
                            'assets/images/onboard_images/${Provider.of<List<OnBoardModel>>(context, listen: false)[index].image}',
                          )
                        : Image.asset(
                            'assets/images/onboard_images/${Provider.of<List<OnBoardModel>>(context, listen: false)[index].image}',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${Provider.of<List<OnBoardModel>>(context, listen: false)[index].title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Exo'),
                        ),
                        Text(
                          "${Provider.of<List<OnBoardModel>>(context, listen: false)[index].desc}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: screenHeigthSize * 0.023),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      pagination: SwiperPagination(
        margin: EdgeInsets.all(0.0),
        builder: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
            return ConstrainedBox(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DotSwiperPaginationBuilder(
                          color: Color(0xFF69818E),
                          size: 12.0,
                          activeSize: 15.0)
                      .build(context, config),
                ),
                constraints: new BoxConstraints.expand(height: 50.0));
          },
        ),
      ),
      viewportFraction: 0.8,
      autoplay: false,
      itemCount: 4,
      loop: false,
      scale: 0.85,
      outer: true,
      onIndexChanged: (value) {
        Provider.of<Function>(context, listen: false)(value);
      },
      controller: _swipperController,
      control: SwiperControl(
        padding: EdgeInsets.all(8),
        iconNext: null,
        iconPrevious: null,
      ),
    );
  }
}
