import 'dart:convert';

import 'package:cGamer/app/data/models/market_place_model/digital_collections_model.dart';
import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/data/models/market_place_model/offers_model.dart';
import 'package:cGamer/app/data/models/market_place_model/store_collections_model.dart';
import 'package:cGamer/app/data/models/user_account_models/register_model.dart';
import 'package:cGamer/app/data/repository/marktplace_repositories/marketplace_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/marketplace/carousel_banner_component.dart';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MarketplaceController extends GetxController {
  final MarketPlaceRepository repository;
  MarketplaceController({required this.repository});

  Rx<DigitalCollectionsModel> collectionsModel = DigitalCollectionsModel().obs;
  Rx<DigitalProducts> digitalProductsModel = DigitalProducts().obs;
  DigitalCollectionsModel? collectionsCategory;
  StoreCollectionsModel? storeCategory;
  Rx<StoreCollectionsModel> storeCollections = StoreCollectionsModel().obs;
  Rx<OffersModel> offersModel = OffersModel().obs;

  final hasCompletedDigitalCollectionRequest = false.obs;
  final hasCompletedStorePartnerCollectionRequest = false.obs;
  final hasCompletedBannersCollectionRequest = false.obs;
  final loading = false.obs;

  @override
  void onReady() async {
    hasCompletedBannersCollectionRequest.value = await getOffersBanner();
    hasCompletedDigitalCollectionRequest.value =
        await getDigitalProductsCollections();
    hasCompletedStorePartnerCollectionRequest.value =
        await getStorePartnersCollections();
    super.onReady();
  }

  Future<bool> getDigitalProductsCollections() async {
    try {
      var response = await repository.digitalProductCollections();
      collectionsModel.value = DigitalCollectionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      collectionsModel.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getStorePartnersCollections() async {
    try {
      var response = await repository.storePartnerCollections();
      storeCollections.value = StoreCollectionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      storeCollections.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool verifyDocumentsSend() {
    String? statusBankly =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .statusBanlky;
    bool hasCompleteRegistration =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .hasCompleteRegistration;
    bool hasSendDocumentation =
        Provider.of<StatusRegisterModel>(Get.context, listen: false)
            .hasSendDocumentation;
    if (hasCompleteRegistration &&
        hasSendDocumentation &&
        statusBankly == "APPROVED")
      return true;
    else
      return false;
  }

  Future<dynamic> getProducts(DigitalCollectionModel? model) async {
    loading.value = true;
    try {
      var response = await repository.products(model?.id ?? 0);

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Algo de errado ao carregar os produtos, tente novamente mais tarde!",
            title: "Atenção");
      } else {
        digitalProductsModel.value = DigitalProducts.fromJson(
          json.decode(utf8.decode(response.bodyBytes)),
        );
        loading.value = false;

        if (digitalProductsModel.value.products != null) {
          Get.toNamed(Routes.MARKETPLACE_SUBCATEGORY_ITEMS, arguments: {
            'products': digitalProductsModel.value.products,
            'title': model?.name
          });
        } else {
          Get.toNamed(Routes.MARKETPLACE_SUBCATEGORY_ITEMS, arguments: {
            'collections': digitalProductsModel.value.collections,
            'title': model?.name
          });
        }
      }
    } catch (e) {
      loading.value = false;
      return Future.error(e);
    }
  }

  void getCollectionsWithCategory(String category, String title) async {
    loading.value = true;
    try {
      var response =
          await repository.digitalProductCollectionsByCategory(category);
      collectionsCategory = DigitalCollectionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      loading.value = false;
      Get.toNamed(Routes.MARKETPLACE_CATEGORY_ITEMS,
          arguments: {'collections': collectionsCategory, 'title': title});
    } catch (e) {
      loading.value = false;
    }
  }

  void getStoreCollectionsWithCategory(String category, String title) async {
    loading.value = true;
    try {
      var response =
          await repository.storePartnerCollectionsByCategory(category);
      storeCategory = StoreCollectionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      loading.value = false;
      Get.toNamed(Routes.MARKETPLACE_CATEGORY_ITEMS,
          arguments: {'store_collections': storeCategory, 'title': title});
    } catch (e) {
      loading.value = false;
    }
  }

  Future<bool> getOffersBanner() async {
    try {
      var response = await repository.offers();
      offersModel.value = OffersModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      offersModel.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

//id, name, linkType, deepLink, image,
  List<String> specialProductsList = [
    'https://pbs.twimg.com/profile_images/1207762480681947142/6148HTPR_400x400.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg9BSoFoiW6KNsGe3jYEmOHbs3wQ0C6HFp0g&usqp=CAU',
    'https://pbs.twimg.com/profile_images/1116032411144466432/jL6_iVjq_400x400.png',
  ];

  List<CarouselBanner> fetchBannersCarrosel() {
    List<CarouselBanner> banners = <CarouselBanner>[];

    if (offersModel.value != null) {
      offersModel.value.offers?.forEach((element) {
        banners.add(CarouselBanner(
            action: () {
              if (element.linkType == "EXTERNAL") {
                GenericUtils.openUrl(element.deepLink ?? "");
              }
            },
            urlImage: element.image ?? ""));
      });
    }
    return banners;
  }

  _setBooleansRequestToFalse() {
    hasCompletedDigitalCollectionRequest.value = false;

    hasCompletedStorePartnerCollectionRequest.value = false;

    hasCompletedBannersCollectionRequest.value = false;
  }

  Future<void> refreshPage() async {
    _setBooleansRequestToFalse();
    hasCompletedDigitalCollectionRequest.value =
        await getDigitalProductsCollections();
    hasCompletedStorePartnerCollectionRequest.value =
        await getStorePartnersCollections();
    hasCompletedBannersCollectionRequest.value = await getOffersBanner();
  }
}
