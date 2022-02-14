import 'package:cGamer/app/controllers/marketplace/subcategory_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/marketplace/subcategory_carousel.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class MarketplaceSubCategoryItemsView extends StatelessWidget {
  SubCategoryController _controller = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Obx(() => CustomAppBar(appBarTxt: _controller.title.value)),
        ),
        body: Obx(
          () => ModalProgressHUD(
            inAsyncCall: _controller.loading.value,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 24, top: 24, right: 24),
                      child: Obx(() => CustomRichText(
                            customText: "${_controller.title.value}",
                            normalText: "Confira os produtos para",
                            customText2: "",
                            customFirst: false,
                            textAlign: TextAlign.start,
                          ))),
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
                          Padding(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              child: Text(
                                _controller.collections != null
                                    ? _controller.collections![index].name ?? ""
                                    : "Produtos digitais",
                                style: textStyle,
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          SubCategoryItemsCarousel(
                            controller: _controller,
                            products: _controller.collections != null
                                ? _controller.collections![index].products
                                : _controller.products,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                    itemCount: _controller.collections != null
                        ? (_controller.collections?.length ?? 0)
                        : 1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // CarouselBannerProductsComponent(
                  //   items: _controller.bannersCarousel,
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
