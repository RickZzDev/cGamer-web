import 'package:cGamer/app/controllers/wallet_controllers/wallet_controller.dart';
import 'package:cGamer/app/data/provider/wallet_providers/wallet_provider.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/ui/components/shimmers/wallet_shimmers/body_card_shimmer.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/ui/components/wallet_components/body_activated_virtual_card.dart';
import 'package:cGamer/app/ui/components/wallet_components/body_data_virtual_card.dart';
import 'package:cGamer/app/ui/components/wallet_components/wallet_header.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletCardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Requester client = Requester();
    CardProvider _apiClient = CardProvider(httpClient: client);
    final WalletController _controller = Get.put(
      WalletController(
        repository: CardRepository(apiClient: _apiClient),
      ),
    );

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return RefreshIndicator(
      onRefresh: () => _controller.refreshPage(),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              appBarTxt: "Cartão virtual",
            ),
          ),
          backgroundColor: secondaryColor,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Container(
            height: screenHeigthSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: secondaryColor,
                      child: WalletHeader(controller: _controller)),
                  Obx(() => !_controller
                          .hasCompletedVirtualCardDetailsRequest.value
                      ? BodyCardShimer()
                      : _controller.virtualCardModel.value.cardName != null
                          ? BodyDataVirtualCard(
                              controller: _controller,
                            )
                          : BodyAtivactedVirtualCard(controller: _controller))
                ],
              ),
            ),
          ))),
    );
  }
}
