import 'package:cGamer/app/controllers/score/partners/partners_points_controller.dart';
import 'package:cGamer/app/routes/routes_export.dart';
import 'package:cGamer/app/ui/components/score_components/parters_points/partners_points_item.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PartnersPoints extends StatefulWidget {
  PartnersPoints({Key? key}) : super(key: key);
  @override
  _PartnersPointsState createState() => _PartnersPointsState();
}

class _PartnersPointsState extends State<PartnersPoints> {
  final PartnersPointsController _controller =
      Get.find<PartnersPointsController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                appBarTxt: "Pontue em parceiros",
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => _controller.refresh(),
              child: Obx(() => ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  itemCount:
                      _controller.statusPartnersResult.value.partners?.length ??
                          0,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(() => PartnersPointsItem(
                            onTap: () {
                              Get.toNamed(Routes.PARTNES_DETAILS,
                                  arguments: <String, dynamic>{
                                    "partnerPoints": _controller
                                        .statusPartnersResult
                                        .value
                                        .partners?[index]
                                  });
                            },
                            isPrime: _controller.isPrime.value,
                            title: _controller.statusPartnersResult.value
                                .partners?[index].title,
                            description: _controller.statusPartnersResult.value
                                .partners?[index].description,
                            earnPoints: _controller.statusPartnersResult.value
                                .partners?[index].earnPoints
                                .toString(),
                            imagePath: _controller.statusPartnersResult.value
                                .partners?[index].iconUrl,
                          ))))),
            ))));
  }
}
