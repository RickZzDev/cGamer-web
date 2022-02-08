import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamesCategoryItemsCarousel extends StatelessWidget {
  const GamesCategoryItemsCarousel(
      {Key? key, required List<DigitalProduct>? products})
      : _products = products,
        super(key: key);

  final List<DigitalProduct>? _products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _products?.length ?? 0,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(
        width: 16,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Get.toNamed(Routes.MARKETPLACE_SUBCATEGORY_ITEMS),
        child: Container(
            width: 100,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                          imageUrl: _products?[index].image ?? "",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 70,
                          width: 70,
                          cacheKey: _products?[index].image ?? "",
                          useOldImageOnUrlChange: true,
                          fit: BoxFit.fill)),
                ),
                Expanded(
                    child: Text(
                  _products?[index].name ?? "",
                  maxLines: 2,
                  style: textStyle.copyWith(fontSize: 14),
                ))
              ],
            )),
      ),
    );
  }
}
