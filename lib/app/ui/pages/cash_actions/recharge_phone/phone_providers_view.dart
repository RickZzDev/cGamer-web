import 'package:cGamer/app/controllers/recharge_phone/phone_provider_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PhoneProvidersView extends StatefulWidget {
  @override
  _PhoneProvidersViewState createState() => _PhoneProvidersViewState();
}

class _PhoneProvidersViewState extends State<PhoneProvidersView> {
  final PhoneProvidersController _controller =
      Get.find<PhoneProvidersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: utils.secondaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CustomAppBar(
            appBarTxt: "Recarga de celular",
          ),
        ),
        body: Obx(
          () => ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              backgroundColor: utils.primaryColor,
            ),
            inAsyncCall: _controller.loading.value,
            child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: CustomRichText(
                          normalText: "Qual a",
                          customText: "operadora?",
                          textAlign: TextAlign.start,
                        )),
                    Obx(
                      () => _controller.hasCompletedProvidersRequest.value
                          ? Expanded(
                              child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    _controller.changePage(_controller
                                        .providers.value.providers?[index]);
                                  },
                                  child: Column(children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: CachedNetworkImage(
                                                    imageUrl: _controller
                                                            .providers
                                                            .value
                                                            .providers?[index]
                                                            .iconUrl ??
                                                        "",
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                              Icons.error,
                                                              color: utils
                                                                  .primaryColor,
                                                            ),
                                                    height: 24,
                                                    width: 24,
                                                    cacheKey: _controller
                                                            .providers
                                                            .value
                                                            .providers?[index]
                                                            .iconUrl ??
                                                        "",
                                                    useOldImageOnUrlChange:
                                                        true,
                                                    fit: BoxFit.cover)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              '${_controller.providers.value.providers?[index].name}',
                                              style: utils.textStyle
                                                  .copyWith(fontSize: 18),
                                            )
                                          ]),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                          )
                                        ]),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.white,
                                    )
                                  ])),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 0),
                              itemCount: _controller
                                      .providers.value.providers?.length ??
                                  0,
                            ))
                          : Container(),
                    ),
                  ],
                )),
          ),
        ));
  }
}
