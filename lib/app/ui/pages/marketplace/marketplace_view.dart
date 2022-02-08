import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';
import 'package:cGamer/app/data/provider/home_provider/home_provider.dart';
import 'package:cGamer/app/data/provider/marketplace_providers/marketplace_provider.dart';
import 'package:cGamer/app/data/repository/home_repository.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/ui/components/marketplace/carousel_banner_products_component.dart';
import 'package:cGamer/app/ui/components/marketplace/my_purchases_component.dart';
import 'package:cGamer/app/ui/components/marketplace/digital_products_area_component.dart';
import 'package:cGamer/app/ui/components/marketplace/digital_grid_area_component.dart';
import 'package:cGamer/app/ui/components/marketplace/special_grid_area_component.dart';
import 'package:cGamer/app/ui/components/marketplace/special_products_area_component.dart';
import 'package:cGamer/app/ui/components/shimmers/marketplace_shimmers/collections_shimmer.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MarketplaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    Requester client = Requester();
    MarketPlaceProvider _apiClient = MarketPlaceProvider(requester: client);
    final MarketplaceController _controller = Get.put(
      MarketplaceController(
        repository: MarketPlaceRepository(apiClient: _apiClient),
      ),
    );

    HomeApiClient _homeApiClient = HomeApiClient(httpClient: client);
    final HomeController _homeController = Get.put(
      HomeController(
        repository: HomeRepository(apiClient: _homeApiClient),
      ),
    );

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: "Gamer Store",
        ),
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _controller.refreshPage(),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MyPurchasesMarketplaceComponent(),
                              Obx(
                                () => _controller
                                        .hasCompletedDigitalCollectionRequest
                                        .value
                                    ? _controller.collectionsModel.value
                                                .products?.length ==
                                            0
                                        ? _controller.verifyDocumentsSend()
                                            ? Container()
                                            : Container()
                                        :
                                        /*
                                     Container(
                                            height: 280,
                                            child: StatusRegisterComponent(
                                              homeController: _homeController,
                                            ),
                                          ): */
                                        DigitalProductsAreaComponent(
                                            marketplaceController: _controller)
                                    : _controller.verifyDocumentsSend()
                                        ? Container()
                                        : CollectionsShimmer(
                                            titleComponent: 'Produtos digitais',
                                          ),
                              ),
                              Obx(() => _controller
                                      .hasCompletedDigitalCollectionRequest
                                      .value
                                  ? _controller.collectionsModel.value.products
                                              ?.length ==
                                          0
                                      ? Container()
                                      : DigitalGridAreaComponent(
                                          marketplaceController: _controller)
                                  : Container()),
                              Obx(
                                () => _controller
                                        .hasCompletedStorePartnerCollectionRequest
                                        .value
                                    ? SpecialProductsAreaComponent(
                                        marketplaceController: _controller)
                                    : CollectionsShimmer(
                                        titleComponent: 'Lojas parceiras',
                                      ),
                              ),
                              SpecialGridAreaComponent(
                                  marketplaceController: _controller),
                              SizedBox(
                                height: 16,
                              ),
                              Obx(
                                () => _controller
                                        .hasCompletedBannersCollectionRequest
                                        .value
                                    ? CarouselBannerProductsComponent(
                                        items:
                                            _controller.fetchBannersCarrosel(),
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
