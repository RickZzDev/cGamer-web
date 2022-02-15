import 'package:cGamer/app/controllers/marketplace/category_games_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/marketplace/games_carousel.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MarketplaceCategoryGamesView extends StatelessWidget {
  CategoryGamesController _controller = Get.find<CategoryGamesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Obx(() => CustomAppBar(appBarTxt: _controller.title.value)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRichText(
                customText: "Adquira",
                normalText: "os produtos abaixo e",
                customText2: "ganhe mais Rubis",
                normalText2: "para",
                customText3: "subir de nível",
                customFirst: true,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 16,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.collections?[index].name ?? "",
                        style: textStyle,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GamesCategoryItemsCarousel(
                        products: _controller.collections?[index].products,
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
                itemCount: _controller.collections?.length ?? 0,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
