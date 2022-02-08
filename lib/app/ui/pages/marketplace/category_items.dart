import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/marketplace/category_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MarketplaceCategoryItemsView extends StatelessWidget {
  final CategoryController _controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(appBarTxt: _controller.title),
        ),
        body: Obx(() => ModalProgressHUD(
              inAsyncCall: _controller.loading.value,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "Confira abaixo maneiras de deixar o seu momento mais divertido ",
                        style: textStyle,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 64,
                          mainAxisSpacing: 32,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.collectionsModel != null
                            ? (_controller.collectionsModel?.products?.length ??
                                0)
                            : (_controller.storeCollectionsModel?.collections
                                    ?.length ??
                                0),
                        padding: EdgeInsets.only(bottom: 8),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => _controller.collectionsModel != null
                              ? _controller.getProducts(_controller
                                  .collectionsModel?.products?[index])
                              : Get.toNamed(
                                  Routes.MARKETPLACE_STORE_PARTNER_DETAILS,
                                  arguments: {
                                      'store_collection': _controller
                                          .storeCollectionsModel
                                          ?.collections?[index]
                                    }),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: Offset(2, 3.0), //(x,y)
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                    color: secondaryColor,
                                    border: Border.all(
                                        width: 1.0, color: primaryColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: CachedNetworkImage(
                                                    imageUrl: _controller.collectionsModel != null
                                                        ? _controller.collectionsModel?.products![index].image ?? ""
                                                        : _controller.storeCollectionsModel?.collections?[index].iconUrl ?? "",
                                                    placeholder: (context, url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    height: 50,
                                                    width: 50,
                                                    cacheKey: _controller
                                                                .collectionsModel !=
                                                            null
                                                        ? _controller.collectionsModel?.products![index].image ?? ""
                                                        : _controller.storeCollectionsModel?.collections?[index].iconUrl ?? "",
                                                    useOldImageOnUrlChange: true,
                                                    fit: BoxFit.cover)),
                                          ),
                                          _controller.storeCollectionsModel !=
                                                      null &&
                                                  _controller.storeCollectionsModel?.collections?[index].offMessage != null
                                              ? Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    transform: Matrix4
                                                        .translationValues(
                                                            36.0, -12.0, 0.0),
                                                    decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4))),
                                                    width: 55,
                                                    height: 16,
                                                    child: Center(
                                                      child: Text(
                                                        _controller
                                                            .storeCollectionsModel?.collections?[index].offMessage ?? "",
                                                        style: textStyle.copyWith(
                                                            fontSize: 12,
                                                            color:
                                                                secondaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ))
                                              : _controller.collectionsModel !=
                                                          null &&
                                                      _controller.collectionsModel?.products?[index].offMessage != null
                                                  ? Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                36.0,
                                                                -12.0,
                                                                0.0),
                                                        decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4))),
                                                        width: 55,
                                                        height: 16,
                                                        child: Center(
                                                          child: Text(
                                                            _controller
                                                                .collectionsModel?.products?[index].offMessage ?? "",
                                                            style: textStyle.copyWith(
                                                                fontSize: 12,
                                                                color:
                                                                    secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ))
                                                  : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      AutoSizeText(
                                        _controller.collectionsModel != null
                                            ? _controller.collectionsModel?.products![index].name ?? ""
                                            : _controller.storeCollectionsModel?.collections?[index].name ?? "",
                                        maxLines: 1,
                                        style: textStyle,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
