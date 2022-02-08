import 'package:cGamer/app/controllers/marketplace/subcategory_controller.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/ui/components/marketplace/subcategory_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubCategoryItemsCarousel extends StatelessWidget {
  const SubCategoryItemsCarousel(
      {Key? key,
      required List<DigitalProduct>? products,
      required SubCategoryController controller})
      : _products = products,
        _controller = controller,
        super(key: key);

  final List<DigitalProduct>? _products;
  final SubCategoryController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 70, maxHeight: 80),
      child: ListView.separated(
          itemCount: _products?.length ?? 0,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 24, right: 24),
          separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  _controller.getProductDetails(_products?[index]);
                },
                child: Obx(() => SubcategoryItem(
                      product: _products?[index],
                      isPrime: _controller.isPrime.value,
                    )));
          }),
    );
  }
}
